cd /apdcephfs/share_916081/jinhuiye/Projects/fairseq
#export PATH=/apdcephfs/share_916081/translation/mt_sys/system_training/ZhEn/tool/python3.7.2/bin/:$PATH
##nobpe=$path/test.output
export PATH=/apdcephfs/share_916081/jinhuiye/Environments/anaconda3/envs/GPT/bin/:$PATH

#pip list | grep fairseq
#if [ $? != 0 ]; then
#  echo 'Install Fairseq First'
#  pip install --editable ./
#fi
#pip install tensorboardX

DATA=zh_xx_2
seed=1
data_bin=/apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/Exp/CSL/data/databin/${DATA}
EVAL_OUTPUT_PATH=/apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/Exp/CSL/results/${DATA}_${seed}
CHECKPOINT_DIR=/apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/Exp/CSL/checkpoints/${DATA}_${seed}

valid_zh=/apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/Exp/CSL/data/rawdata/valid.zh
valid_xx=/apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/Exp/CSL/data/rawdata/valid.xx




mkdir -p $CHECKPOINT_DIR
mkdir -p $EVAL_OUTPUT_PATH/logs
mkdir -p $EVAL_OUTPUT_PATH/evaluation

cp $valid_zh $EVAL_OUTPUT_PATH/evaluation/valid.zh
cp $valid_xx $EVAL_OUTPUT_PATH/evaluation/valid.xx


CUDA_VISIBLE_DEVICES=0  python train.py $data_bin \
  -s zh -t xx \
  --fp16 \
  --encoder-layers 2 \
  --decoder-layers 2 \
  --lr 0.0007 --min-lr 1e-09 \
  --weight-decay 0.0 --clip-norm 0.1 --dropout 0.3 \
  --max-tokens 2048 \
  --update-freq 1 \
  --arch transformer \
  --optimizer adam --adam-betas '(0.9, 0.98)' \
  --lr-scheduler inverse_sqrt \
  --warmup-init-lr 1e-07 \
  --warmup-updates 2000 \
  --save-dir $CHECKPOINT_DIR \
  --tensorboard-logdir ./results/$DATA/logs \
  --criterion label_smoothed_cross_entropy \
  --label-smoothing 0.1 \
  --no-progress-bar \
  --log-format simple \
  --log-interval 100 \
  --save-interval-updates 500 \
  --max-update 10000 \
  --max-epoch 100 \
  --beam 1 \
  --remove-bpe \
  --quiet \
  --all-gather-list-size 522240 \
  --num-ref $DATA=1 \
  --valid-decoding-path $EVAL_OUTPUT_PATH/evaluation \
  --multi-bleu-path ./scripts/ \
  --save-interval 5 \
  --keep-interval-updates 100 \
  --keep-last-epochs 5 \
  |& tee $EVAL_OUTPUT_PATH/train.log.$seed





seed=11
data_bin=/apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/Exp/CSL/data/databin/${DATA}/
EVAL_OUTPUT_PATH=/apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/Exp/CSL/results/${DATA}_${seed}/
CHECKPOINT_DIR=/apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/Exp/CSL/checkpoints/${DATA}_${seed}


mkdir -p $CHECKPOINT_DIR
mkdir -p $EVAL_OUTPUT_PATH/logs
mkdir -p $EVAL_OUTPUT_PATH/evaluation

cp $valid_zh $EVAL_OUTPUT_PATH/evaluation/valid.zh
cp $valid_xx $EVAL_OUTPUT_PATH/evaluation/valid.xx

CUDA_VISIBLE_DEVICES=0  python train.py $data_bin \
  -s zh -t xx \
  --fp16 \
  --encoder-layers 2 \
  --decoder-layers 2 \
  --lr 0.0007 --min-lr 1e-09 \
  --weight-decay 0.0 --clip-norm 0.1 --dropout 0.3 \
  --max-tokens 2048 \
  --update-freq 1 \
  --arch transformer \
  --optimizer adam --adam-betas '(0.9, 0.98)' \
  --lr-scheduler inverse_sqrt \
  --warmup-init-lr 1e-07 \
  --warmup-updates 2000 \
  --save-dir $CHECKPOINT_DIR \
  --tensorboard-logdir ./results/$DATA/logs \
  --criterion label_smoothed_cross_entropy \
  --label-smoothing 0.1 \
  --no-progress-bar \
  --log-format simple \
  --log-interval 100 \
  --save-interval-updates 500 \
  --max-update 10000 \
  --max-epoch 100 \
  --beam 1 \
  --remove-bpe \
  --quiet \
  --all-gather-list-size 522240 \
  --num-ref $DATA=1 \
  --valid-decoding-path $EVAL_OUTPUT_PATH/evaluation \
  --multi-bleu-path ./scripts/ \
  --save-interval 5 \
  --keep-interval-updates 100 \
  --keep-last-epochs 5 \
  |& tee $EVAL_OUTPUT_PATH/train.log.$seed





seed=111
data_bin=/apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/Exp/CSL/data/databin/${DATA}/
EVAL_OUTPUT_PATH=/apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/Exp/CSL/results/${DATA}_${seed}/
CHECKPOINT_DIR=/apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/Exp/CSL/checkpoints/${DATA}_${seed}


mkdir -p $CHECKPOINT_DIR
mkdir -p $EVAL_OUTPUT_PATH/logs
mkdir -p $EVAL_OUTPUT_PATH/evaluation

cp $valid_zh $EVAL_OUTPUT_PATH/evaluation/valid.zh
cp $valid_xx $EVAL_OUTPUT_PATH/evaluation/valid.xx

CUDA_VISIBLE_DEVICES=0  python train.py $data_bin \
  -s zh -t xx \
  --fp16 \
  --encoder-layers 2 \
  --decoder-layers 2 \
  --lr 0.0007 --min-lr 1e-09 \
  --weight-decay 0.0 --clip-norm 0.1 --dropout 0.3 \
  --max-tokens 2048 \
  --update-freq 1 \
  --arch transformer \
  --optimizer adam --adam-betas '(0.9, 0.98)' \
  --lr-scheduler inverse_sqrt \
  --warmup-init-lr 1e-07 \
  --warmup-updates 2000 \
  --save-dir $CHECKPOINT_DIR \
  --tensorboard-logdir ./results/$DATA/logs \
  --criterion label_smoothed_cross_entropy \
  --label-smoothing 0.1 \
  --no-progress-bar \
  --log-format simple \
  --log-interval 100 \
  --save-interval-updates 500 \
  --max-update 10000 \
  --max-epoch 100 \
  --beam 1 \
  --remove-bpe \
  --quiet \
  --all-gather-list-size 522240 \
  --num-ref $DATA=1 \
  --valid-decoding-path $EVAL_OUTPUT_PATH/evaluation \
  --multi-bleu-path ./scripts/ \
  --save-interval 5 \
  --keep-interval-updates 100 \
  --keep-last-epochs 5 \
  |& tee $EVAL_OUTPUT_PATH/train.log.$seed



