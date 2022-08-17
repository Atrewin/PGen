TRAIN_FILE=/apdcephfs/share_916081/jinhuiye/Projects/GPT2/Data/Training/PH4T/case_prompt_with_number_traning_data_30_sample_10000.txt
TEST_FILE=/apdcephfs/share_916081/jinhuiye/Projects/GPT2/Data/Training/PH4T/case_prompt_with_number_traning_data_30_sample_100.txt

OUTPUT=/apdcephfs/share_916081/jinhuiye/Projects/GPT2/Model/De/case_prompt_with_number

cd /apdcephfs/share_916081/jinhuiye/Projects/transformers/examples/pytorch/language-modeling
export PATH=/apdcephfs/share_916081/jinhuiye/Environments/anaconda3/envs/GPT/bin/:$PATH
Model=/apdcephfs/share_916081/jinhuiye/Projects/GPT2/Model/Source/german-gpt2

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


