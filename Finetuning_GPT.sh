TRAIN_FILE=De/phoenix2014T.train.de # PATH TO THE TEXT SIDE OF SLT DATASET
TEST_FILE=De/phoenix2014T.dev.de

Model=dbmdz/german-gpt2 #YOUR PART TO THE PRE-TRAINED GPT (i.e., https://huggingface.co/dbmdz/german-gpt2)
OUTPUT=Models #YOUR PART TO　SAVE THE FINETUNING GPT

CUDA_VISIBLE_DEVICES=0,1,2 python run_clm.py \
--model_name_or_path ${Model} \
--train_file $TRAIN_FILE \
--validation_file $TEST_FILE \
--do_train \
--per_device_train_batch_size 8 \
--num_train_epochs 20 \
--save_strategy epoch \
--per_device_eval_batch_size 8 \
--gradient_accumulation_steps 32 \
--output_dir $OUTPUT \
--overwrite_output_dir


