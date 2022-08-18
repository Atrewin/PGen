import random
import tqdm
from dataset import Prompt_prefix
from transformers import pipeline, set_seed
from tools import writer2text, read_all_dataset

class DomainDataByGPT():
    def __init__(self, model_path='dbmdz/german-gpt2'):
        self.model_path = model_path

    def main_case_prompt(self, case_num=10, sample_num=15,
                   spoken_file=r"data/paralle/De/phoenix2014T.train.de",
                    save_file="data/monolingual/GPT_domain.de.txt"
                   ):
        dataset = Prompt_prefix(spoken_file=spoken_file,
                                gloss_file=spoken_file)

        data_row = dataset.get_case_prompt_without_number(case_num=case_num, sample_num=sample_num)

        max_len = case_num*23 + 150 # this is for upspeed, but assert max_len > mean_len(sentence)*（case_number+1） + bias
        generator = pipeline('text-generation', model=self.model_path)
        check_sample = True
        if check_sample:
            output_1 = generator(data_row[0], max_length=max_len)[0]["generated_text"]
            print("#"*28)
            print(output_1)

            output_2 = generator(data_row[-1], max_length=max_len)[0]["generated_text"]
            print("#" * 28)
            print(output_2)
        # get generate domain data
        # do_eval
        save_step = 200
        for index in tqdm(range(0, sample_num, save_step)):
            output_list = generator(data_row[index:index + save_step], max_length=max_len)
            generated_domain_sentence_list = []
            count_num = 0
            for output in output_list:
                generated_texts = self.get_generated_multi_text_by_case_without_number(generated_sentences=output[0]["generated_text"],
                                                         case_num=case_num)

                for the_times_sentence, generated_text in enumerate(generated_texts):
                    if the_times_sentence >= len(generated_domain_sentence_list):# 需要按第几句分桶
                        generated_domain_sentence_list.append([])


                    generated_domain_sentence_list[the_times_sentence].append(generated_text)
                    count_num += 1

            for index_j in range(len(generated_domain_sentence_list)):
                save_file_x = save_file + f"_{index_j}"
                writer2text(data_rows=generated_domain_sentence_list[index_j], file_path=save_file_x, mode="a")

    def main_keywords_prompt(self, input_file=None,times=1, keep_rate=0.2, save_file=None):
        dataset = Prompt_prefix(spoken_file=input_file,
                                gloss_file=input_file)
        set_seed(random.randint(0,1000))
        data_row = dataset.keyword_prompt(times=times, keep_word_order=True,keep_rate=keep_rate)


        generator = pipeline('text-generation', model=self.model_path)
        check_sample = True
        if check_sample:
            output_1 = generator(data_row[0], max_length=32, num_workers=8)[0]["generated_text"]
            print("#"*28)
            print(output_1)

            output_2 = generator(data_row[-1], max_length=32)[0]["generated_text"]
            print("#" * 28)
            print(output_2)
            writer2text(data_rows=[output_1, output_2], file_path=save_file+"_prompt_org", mode="a")

        # get generate domain data
        # do_eval
        random.shuffle(data_row)
        sample_num = len(data_row)
        save_case = 200
        for index in range(0, sample_num, save_case):
            output_list = generator(data_row[index:index + save_case], max_length=32, num_workers=20)
            generated_domain_sentence = []
            generated_domain_sentence_or = []
            count_num = 0
            for output in output_list:
                total_sentence, generated_text = self.get_keywords_generated_text(generated_sentences=output[0]["generated_text"])

                if self.good_generated_sentence(generated_text):
                    generated_domain_sentence.append(generated_text)
                    generated_domain_sentence_or.append(total_sentence)

                    count_num += 1
            set_seed(random.randint(0, 1000))
            writer2text(data_rows=generated_domain_sentence, file_path=save_file, mode="a")
            writer2text(data_rows=generated_domain_sentence_or, file_path=save_file+"_prompt_org", mode="a")

        print("  ")
    def main_prefix_prompt(self, times=1, keep_rate=0.2, save_file="Data/Sign/Generated_data/De/de_keyword_prompt_keep_order.txt"):
        dataset = Prompt_prefix(spoken_file=r"Data/Sign/phoenix2014T.train.de",
                                gloss_file=r"Data/Sign/phoenix2014T.train.gloss.lower")

        data_row = dataset.prefix_prompt(times=times, keep_rate=keep_rate)


        generator = pipeline('text-generation', model=self.model_path)
        check_sample = True
        if check_sample:
            output_1 = generator(data_row[0], max_length=64)[0]["generated_text"]
            print("#"*28)
            print(output_1)

            output_2 = generator(data_row[-1], max_length=64)[0]["generated_text"]
            print("#" * 28)
            print(output_2)
        # get generate domain data
        # do_eval
        # random.shuffle(data_row)
        sample_num = len(data_row)
        save_case = 100
        for index in range(0, sample_num, save_case):
            output_list = generator(data_row[index:index + save_case], max_length=64)
            generated_domain_sentence = []
            count_num = 0
            for output in output_list:
                total_sentence = self.get_prefix_generated_text(generated_sentences=output[0]["generated_text"])

                if self.good_generated_sentence(total_sentence):
                    generated_domain_sentence.append(total_sentence)
                    count_num += 1

            writer2text(data_rows=generated_domain_sentence, file_path=save_file, mode="a")

        print("  ")



    def get_generated_text(self, generated_sentences: str, case_num=None):
        sentences = generated_sentences.split("\n")

        if case_num < len(sentences):
            generated_sentence = sentences[case_num]
            generated_sentence = generated_sentence.lstrip(f"{case_num + 1}. ")

            return generated_sentence

        return ""
    def get_keywords_generated_text(self, generated_sentences: str):
        or_sentences = generated_sentences.split("\n")[0]
        sentences = or_sentences.split("Sentence # ")

        if 1 < len(sentences) :
            generated_sentence = sentences[-1]
            return or_sentences, generated_sentence

        return or_sentences, ""
    def get_prefix_generated_text(self, generated_sentences: str):
        or_sentences = generated_sentences.split("\n")[0]

        if 1 < len(or_sentences) :
            return or_sentences

        return ""

    def get_generated_multi_text(self, generated_sentences: str, case_num=None):
        sentences = generated_sentences.split("\n")

        sentences_list = []
        if case_num < len(sentences):
            G_sentences = sentences[case_num:].split(".")

            for s in G_sentences:
                n_s = self.good_generated_sentence(s)
                if n_s != None:
                    sentences_list.append(n_s)
                else:
                    break

        return sentences_list

    def get_generated_multi_text_by_case_without_number(self, generated_sentences: str, case_num=None):
        sentences = generated_sentences.split("\n")

        sentences_list = []
        if case_num < len(sentences):
            G_sentences = sentences[case_num:]
            for s in G_sentences:
                s = s.replace("<\s>", "")
                s = s.replace("<s>", "")
                s =s.strip()
                n_s = self.good_generated_sentence_de(s)
                if n_s != None:
                    sentences_list.append(n_s)
                else:
                    break

        return sentences_list


    def get_good_generated_sentence_zh(self, text):
        if 10 < len(text) and len(text) < 50:
            # text_x = text.split(". ")
            # if text_x[0].isdigit():
            return text
        else:
            return None

    def good_generated_sentence_de(self, text):
        if 10 < len(text) and len(text) < 200:

            return text
        else:
            return None

    def good_generated_sentence(self,text):

        if 5 < len(text):
            return True
        else:
            return False

    def cat_and_clear_generated_domain_data(self, source_file, target_file):

        rawdata_list = read_all_dataset(filename=source_file)

        target_data_list = []
        ## 其实数据量没有到达需要这样子读取的
        for batch in range(0, len(rawdata_list), 1000):
            right = min(len(rawdata_list), batch + 1000)
            for sentence in rawdata_list[batch:right]:
                sentence = self.clear_data(sentence=sentence)
                if sentence != None:
                    target_data_list.append(sentence)

        writer2text(data_rows=target_data_list, file_path=target_file)


    def clear_data(self, sentence: str, case=1):
        if case == 2:
            if sentence[0:4] == "23. ":
                sentence = sentence[4:]
                return sentence
            else:
                return None

        if case == 1:

            sentence = sentence.lstrip(" ")

            sentence = sentence.split("<\s>")[0]

            return sentence


        pass

        return None

import argparse




if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    # data url parameters
    # time.sleep(5)

    parser.add_argument('--input_file',
                        default="data/paralle/De/phoenix2014T.train.de",
                        help='PATH TO THE TEXT SIDE OF SLT DATASET')

    parser.add_argument('--case_num',
                        default=20,
                        help='THE LENGTH OF PREFIX')
    parser.add_argument('--model_path',
                        default="dbmdz/german-gpt2",
                        help='MODEL PARH FOR GPT')
    parser.add_argument('--generation_num',
                        default=1000000,
                        type=int,
                        help='THE TARGET SIZE OF DA SENTENCES')

    parser.add_argument('--save_file',
                        default="data/monolingual/de_case_prompt_without_number.txt",
                        help='PATH TO SAVE DA SENTENCES')
    opt = parser.parse_args()
    #
    # build_keyword_promt_finetuning_data()

    A = DomainDataByGPT(model_path=opt.model_path)
    A.main_case_prompt(case_num=int(opt.case_num), sample_num=opt.generation_num, save_file=opt.save_file,
                 spoken_file=opt.input_file)
