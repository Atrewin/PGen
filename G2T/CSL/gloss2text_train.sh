cd /home/yejinhui/Projects/fairseq_old
export PATH=/home/yejinhui/Envs/anaconda3/envs/GPT/bin/:$PATH

#pip list | grep fairseq
#if [ $? != 0 ]; then
#  echo 'Install Fairseq First'
#  pip install --editable ./
#fi

DATA=xx_zh
data_bin=/home/yejinhui/Projects/PGen/G2T/CSL/data/databin/${DATA}

valid_s=/home/yejinhui/Projects/PGen/G2T/CSL/data/rawdata/valid.zh
valid_t=/home/yejinhui/Projects/PGen/G2T/CSL/data/rawdata/valid.xx

seed=11
EVAL_OUTPUT_PATH=/home/yejinhui/Projects/PGen/G2T/CSL/results/${DATA}_$seed/
CHECKPOINT_DIR=/home/yejinhui/Projects/PGen/G2T/CSL/checkpoints/${DATA}_$seed

mkdir -p $CHECKPOINT_DIR
mkdir -p $EVAL_OUTPUT_PATH/evaluation
mkdir -p $EVAL_OUTPUT_PATH/logs

cp $valid_s $EVAL_OUTPUT_PATH/evaluation/valid.zh
cp $valid_t $EVAL_OUTPUT_PATH/evaluation/valid.xx



CUDA_VISIBLE_DEVICES=3  python train.py $data_bin \
  -s xx -t zh \
  --fp16 \
  --encoder-layers 2 \
  --decoder-layers 2 \
  --lr 0.0007 --min-lr 1e-09 \
  --weight-decay 0.0 --clip-norm 0.1 --dropout 0.3 \
  --max-tokens 128 \
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
  --max-update 50000 \
  --max-epoch 50 \
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

#seed=111
#EVAL_OUTPUT_PATH=/home/yejinhui/Projects/PGen/G2T/CSL/results/${DATA}_$seed/
#CHECKPOINT_DIR=/home/yejinhui/Projects/PGen/G2T/CSL/checkpoints/${DATA}_$seed
#
#mkdir -p $CHECKPOINT_DIR
#mkdir -p $EVAL_OUTPUT_PATH/evaluation
#mkdir -p $EVAL_OUTPUT_PATH/logs
#
#cp $valid_s $EVAL_OUTPUT_PATH/evaluation/valid.zh
#cp $valid_t $EVAL_OUTPUT_PATH/evaluation/valid.xx
#
#
#
#CUDA_VISIBLE_DEVICES=0  python train.py $data_bin \
#  -s xx -t zh \
#  --fp16 \
#  --encoder-layers 2 \
#  --decoder-layers 2 \
#  --lr 0.0007 --min-lr 1e-09 \
#  --weight-decay 0.0 --clip-norm 0.1 --dropout 0.3 \
#  --max-tokens 2048 \
#  --update-freq 1 \
#  --arch transformer \
#  --optimizer adam --adam-betas '(0.9, 0.98)' \
#  --lr-scheduler inverse_sqrt \
#  --warmup-init-lr 1e-07 \
#  --warmup-updates 2000 \
#  --save-dir $CHECKPOINT_DIR \
#  --tensorboard-logdir ./results/$DATA/logs \
#  --criterion label_smoothed_cross_entropy \
#  --label-smoothing 0.1 \
#  --no-progress-bar \
#  --log-format simple \
#  --log-interval 100 \
#  --save-interval-updates 500 \
#  --max-update 50000 \
#  --max-epoch 100 \
#  --beam 1 \
#  --remove-bpe \
#  --quiet \
#  --all-gather-list-size 522240 \
#  --num-ref $DATA=1 \
#  --valid-decoding-path $EVAL_OUTPUT_PATH/evaluation \
#  --multi-bleu-path ./scripts/ \
#  --save-interval 5 \
#  --keep-interval-updates 100 \
#  --keep-last-epochs 5 \
#  |& tee $EVAL_OUTPUT_PATH/train.log.$seed
#


#
#seed=11
#
#EVAL_OUTPUT_PATH=/home/yejinhui/Projects/PGen/G2T/CSL/results/${DATA}_$seed/
#CHECKPOINT_DIR=/home/yejinhui/Projects/PGen/G2T/CSL/checkpoints/${DATA}_$seed
#
#mkdir -p $CHECKPOINT_DIR
#mkdir -p $EVAL_OUTPUT_PATH/evaluation
#mkdir -p $EVAL_OUTPUT_PATH/logs
##mkdir -p ./results/$DATA/logs/
#
#
#cp $valid_s $EVAL_OUTPUT_PATH/evaluation/valid.zh
#cp $valid_t $EVAL_OUTPUT_PATH/evaluation/valid.xx
#
#CUDA_VISIBLE_DEVICES=0  python train.py $data_bin \
#  -s xx -t zh \
#  --seed $seed \
#  --fp16 \
#  --encoder-layers 2 \
#  --decoder-layers 2 \
#  --lr 0.0007 --min-lr 1e-09 \
#  --weight-decay 0.0 --clip-norm 0.1 --dropout 0.3 \
#  --max-tokens 128 \
#  --update-freq 1 \
#  --arch transformer \
#  --optimizer adam --adam-betas '(0.9, 0.98)' \
#  --lr-scheduler inverse_sqrt \
#  --warmup-init-lr 1e-07 \
#  --warmup-updates 2000 \
#  --save-dir $CHECKPOINT_DIR \
#  --tensorboard-logdir ./results/$DATA/logs \
#  --criterion label_smoothed_cross_entropy \
#  --label-smoothing 0.1 \
#  --no-progress-bar \
#  --log-format simple \
#  --log-interval 200 \
#  --save-interval-updates 500 \
#  --max-update 3000000 \
#  --max-epoch 50 \
#  --beam 1 \
#  --remove-bpe \
#  --quiet \
#  --all-gather-list-size 522240 \
#  --num-ref $DATA=1 \
#  --valid-decoding-path $EVAL_OUTPUT_PATH/evaluation \
#  --multi-bleu-path ./scripts/ \
#  --save-interval 5 \
#  --keep-interval-updates 100 \
#  --keep-last-epochs 5 \
#  |& tee $EVAL_OUTPUT_PATH/train.log.$seed
#
##
#
#seed=111
#EVAL_OUTPUT_PATH=/home/yejinhui/Projects/PGen/G2T/CSL/results/${DATA}_$seed/
#CHECKPOINT_DIR=/home/yejinhui/Projects/PGen/G2T/CSL/checkpoints/${DATA}_$seed
#
#mkdir -p $CHECKPOINT_DIR
#mkdir -p $EVAL_OUTPUT_PATH/evaluation
#mkdir -p $EVAL_OUTPUT_PATH/logs
#
#
#cp /apdcephfs/share_916081/translation/jinhui/Gloss_to_Text/DSL.data_word/DSL.dev.zh $EVAL_OUTPUT_PATH/evaluation/valid.zh
#cp /apdcephfs/share_916081/translation/jinhui/Gloss_to_Text/DSL.data_word/DSL.dev.gloss.lower $EVAL_OUTPUT_PATH/evaluation/valid.xx
#
#
#CUDA_VISIBLE_DEVICES=0  python train.py $data_bin \
#  -s xx -t zh \
#  --seed $seed \
#  --fp16 \
#  --encoder-layers 2 \
#  --decoder-layers 2 \
#  --lr 0.0007 --min-lr 1e-09 \
#  --weight-decay 0.0 --clip-norm 0.1 --dropout 0.3 \
#  --max-tokens 128 \
#  --update-freq 1 \
#  --arch transformer \
#  --optimizer adam --adam-betas '(0.9, 0.98)' \
#  --lr-scheduler inverse_sqrt \
#  --warmup-init-lr 1e-07 \
#  --warmup-updates 2000 \
#  --save-dir $CHECKPOINT_DIR \
#  --tensorboard-logdir ./results/$DATA/logs \
#  --criterion label_smoothed_cross_entropy \
#  --label-smoothing 0.1 \
#  --no-progress-bar \
#  --log-format simple \
#  --log-interval 100 \
#  --save-interval-updates 500 \
#  --max-update 3000000 \
#  --max-epoch 50 \
#  --beam 1 \
#  --remove-bpe \
#  --quiet \
#  --all-gather-list-size 522240 \
#  --num-ref $DATA=1 \
#  --valid-decoding-path $EVAL_OUTPUT_PATH/evaluation \
#  --multi-bleu-path ./scripts/ \
#  --save-interval 5 \
#  --keep-interval-updates 100 \
#  --keep-last-epochs 5 \
#  |& tee ./results/$DATA/logs/train.log.$seed


