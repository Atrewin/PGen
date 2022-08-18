#!/usr/bin/env Python
# coding=utf-8
import csv

def set_translator():
    pass
def read_all_dataset(filename):
    with open(filename, "r", encoding="utf-8") as f:
        lines = f.readlines()

    for index, line in enumerate(lines):
        if line[-1] == "\n":
            lines[index] = line[0:-1]

    return lines


def writer2csv(data_rows: [], file_path=None):

    with open(file_path, "a", newline="", encoding="utf-8") as f:
        csv_writer = csv.writer(f)
        csv_writer.writerows(data_rows)

def writer2text(data_rows: [], file_path="try.txt", mode="w"):

    with open(file_path, mode, newline="", encoding="utf-8") as f:

        for row in data_rows:
            if len(row) == 0 or row[-1] != "\n":
                f.write("{}\n".format(row))
            else:
                f.write(row)



def writer2all(target_txt, file_path="try.txt", mode="w"):
    # 写会txt

    with open(file_path, mode, encoding="utf-8") as f:
        f.write(target_txt)


def check_lines_number(input_txt: str, target_txt: str):
    input_txt_number = input_txt.split("\n")
    target_txt_number = target_txt.split("\n")

    return len(input_txt_number) == len(target_txt_number) + 1


import os, json
def save_to_json(obj,filepath=".",  filename="1.json", ):
    filename = os.path.join(filepath,filename)
    with open(filename, "w", encoding="utf-8") as f:
        json.dump(obj,f, ensure_ascii=False)


def load_json(path):
    with open(path, 'r', encoding="utf-8") as load_f:
        load_dict = json.load(load_f)

    return load_dict

def lower(source_file=None):

    row_data = read_all_dataset(filename=source_file)

    for index in range(len(row_data)):
        row_data[index] = row_data[index].lower()

    writer2text(data_rows=row_data, file_path=source_file+".lower")


if __name__ == '__main__':

    pass






