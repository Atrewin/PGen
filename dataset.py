
import math
from transformers import pipeline, set_seed

def read_all_dataset(filename):
    with open(filename, "r", encoding="utf-8") as f:
        lines = f.readlines()

    return lines


from torch.utils.data import Dataset, DataLoader







import random

class Prompt_prefix(Dataset):
    def __init__(self, spoken_file="Data/Sign/phoenix2014T.dev.de", gloss_file="Data/Sign/phoenix2014T.dev.gloss.lower",
             ):


        self.sentence_gloss = self.read_row_data(spoken_file=spoken_file, gloss_file=gloss_file)

        #
    def get_case_prompt_without_number(self, case_num=20, sample_num=10000):
        self.prompts = []

        for row in range(sample_num):
            examples = random.sample(self.sentence_gloss, case_num)

            input_prompt = ""
            for num in range(case_num):
                input_prompt += f"{examples[num]['spoken']}\n"
            #
            input_prompt += ""
            self.prompts.append(input_prompt)

        return self.prompts

    def get_case_prompt_with_number(self, case_num=20, sample_num=10000):
        self.prompts = []

        for row in range(sample_num):
            examples = random.sample(self.sentence_gloss, case_num)

            input_prompt = ""
            for num in range(case_num):
                input_prompt += f"{num+1}. {examples[num]['spoken']}\n"
            #
            input_prompt += f"{case_num+1}."
            self.prompts.append(input_prompt)

        return self.prompts
    def keyword_prompt(self, times=3, keep_word_order=True,keep_rate=0.2):
        prompt_pprefix_sentences = []
        inputs = self.spokens

        for or_sentence in list(set(inputs)):
            for time in range(times):
                words_list = or_sentence.split(" ")
                # L1 = random.sample(range(0, len(words_list)), math.ceil(len(words_list)*0.2))
                # 感觉还是保持乱序好些
                keywords_index = random.sample(range(0, len(words_list)), math.ceil(len(words_list) * keep_rate))
                if keep_word_order:
                    keywords_index.sort()
                keywords = []
                for index in keywords_index:
                    keywords.append(words_list[index])

                # keywords = words_list.index(keywords_index)
                prefix = "Keyword # " + " ".join(keywords)

                prompt_prefix = prefix + " @ " + "Sentence # "
                prompt_pprefix_sentences.append(prompt_prefix)

        return prompt_pprefix_sentences

    def prefix_prompt(self, times=1, keep_rate=0.2):
        prompt_pprefix_sentences = []
        inputs = self.spokens

        for or_sentence in inputs:
            for time in range(times):
                words_list = or_sentence.split(" ")
                # L1 = random.sample(range(0, len(words_list)), math.ceil(len(words_list)*0.2))

                prefixed_right_index = min(math.ceil(len(words_list) * keep_rate) + 1, len(words_list))

                prompt_prefix = words_list[0:prefixed_right_index]
                prompt_prefix = " ".join(prompt_prefix) + " "
                prompt_pprefix_sentences.append(prompt_prefix)

        return prompt_pprefix_sentences


    def get_T5_summary_prompt(self):

        self.prompts = []
        for row in self.sentence_gloss:
            input_prompt = f"summarize: {row['spoken']}"
            self.prompts.append(input_prompt)
        return self.prompts

    def get_T5_translation_prompt(self):

        self.prompts = []
        for row in self.sentence_gloss:
            input_prompt = f"translate German to Gloss: {row['spoken']}"
            self.prompts.append(input_prompt)
        return self.prompts

    def get_T5_translation_G2T_prompt(self):

        self.prompts = []
        for row in self.sentence_gloss:
            input_prompt = f"translate Gloss to German: {row['gloss']}"
            self.prompts.append(input_prompt)
        return self.prompts


    def get_T5_seq2seq_prompt(self):

        self.prompts = []
        for row in self.sentence_gloss:
            input_prompt = f"{row['spoken']}"
            self.prompts.append(input_prompt)
        return self.prompts

    def get_T5_qa_prompt(self):

        self.prompts = []
        for row in self.sentence_gloss:
            input_prompt = f"question: What are the key words for the sentence? context: {row['spoken']}"
            self.prompts.append(input_prompt)
        return self.prompts



    def set_prompt_text_example_n(self, n=1):
        self.prompts = []

        for row in self.sentence_gloss:
            examples = random.sample(self.sentence_gloss, n)
            for example_index in range(len(examples)):
                while row == examples[example_index]:
                    examples[example_index] = random.sample(self.sentence_gloss, 1)[0]

            input_prompt = ""
            for ex in examples:

                input_prompt += f"<s> {ex['spoken']} </s> @ {ex['gloss']} "

            input_prompt += f"<s> {row['spoken']} </s> @ "

            self.prompts.append(input_prompt)

        return self.prompts


    def get_prompt_text_example_n(self, case_num=1, sample_num=100000):
        prompts = []

        for sample_i in range(sample_num):
            examples = random.sample(self.sentence_gloss, case_num)
            input_prompt = ""
            for index, ex in enumerate(examples):
                input_prompt += f"{index + 1 }. {ex['spoken']}\n"

            input_prompt += f"{case_num + 1}. "
            prompts.append(input_prompt)

        return prompts


    def __len__(self):
        return len(self.prompts)

    def __getitem__(self, item):
        return self.prompts[item]

    def read_row_data(self, spoken_file=None, gloss_file=None):
        spoken_gloss_pairs = []

        glosses = read_all_dataset(gloss_file)

        spokens = read_all_dataset(spoken_file)

        for index in range(len(glosses)):
            glosses[index] = glosses[index].replace('\n', '').lower()
            spokens[index] = spokens[index].replace('\n', '')


            spoken_gloss_pairs.append(
                {"spoken": spokens[index], "gloss": glosses[index]})

        self.glosses = glosses
        self.spokens = spokens

        return spoken_gloss_pairs

# TO DO
from tools import *
















def lower(filer="N"):

    dataset = read_all_dataset(filename=filer)
    answer = []
    for sentence in dataset:
        answer.append(sentence.lower())

    writer2text(data_rows=answer, file_path=filer)


def is_good_sentence(sentence):
    temp = sentence.split(" ")
    return True

def unique_sentence_txt(source_file=""):
    data_row = read_all_dataset(source_file)

    sentence_dict = {}

    for row in data_row:
        row = row.replace(" [unused1]", "").strip()
        if not is_good_sentence(row):
            continue
        if row not in sentence_dict.keys():
            sentence_dict[row] = 1
        else:
            sentence_dict[row] += 1
    print(len(data_row))
    print(len(sentence_dict.keys()))

    unique_rows = list(sentence_dict.keys())
    random.shuffle(unique_rows)
    writer2text(data_rows=unique_rows, file_path=source_file+".unique")





def make_unine_pall_data(spoken_file="", gloss_file=""):
    spokens =read_all_dataset(spoken_file)
    glosses = read_all_dataset(gloss_file)

    unique_pair_dict = {}
    spokens_unique = []
    glosses_unique = []
    for index in range(len(spokens)):
        key = spokens[index]+glosses[index]
        if key not in unique_pair_dict.keys():
            spokens_unique.append(spokens[index])
            glosses_unique.append(glosses[index])
            unique_pair_dict[key] = 1

    print(len(spokens_unique))
    writer2text(data_rows=spokens_unique, file_path=spoken_file+".unique")
    writer2text(data_rows=glosses_unique, file_path=gloss_file+".unique")


    pass

if __name__ == '__main__':


    pass
