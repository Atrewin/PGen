



input_file=data/paralle/De/phoenix2014T.train.de #PATH TO THE TEXT SIDE OF SLT DATASET
model_path=Models #YOUR PART TOSAVE THE FINETUNING GPT


case_num=20
save_path=data/monolingual/ #PATH TO SAVE DA SENTENCES
mkdir -p $save_path
save_file=${save_path}/de_case_prompt_without_number.txt

CUDA_VISIBLE_DEVICES=0 python generate_germnan_domain.py --input_file $input_file --model_path ${model_path} --case_num ${case_num} --save_file $save_file

