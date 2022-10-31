

cd /home/yejinhui/Projects/fairseq
export PATH=/home/yejinhui/Envs/anaconda3/envs/PGen/bin/:$PATH
#pip install --editable ./
#pip list | grep fairseq
if [ $? != 0 ]; then
  echo 'Install Fairseq First'
  pip install --editable ./
fi

TEXT=/home/yejinhui/Projects/PGen/G2T/CSL/data/rawdata/tempdata
Mode=xx_zh
data_bin_path=/home/yejinhui/Projects/PGen/G2T/CSL/data/databin/${Mode}

#nobpe=$path/test.output
# TDOD for Text 2 Gloss
#fairseq-preprocess --source-lang zh --target-lang xx \
#  --trainpref $TEXT/train --validpref $TEXT/valid \--testpref $TEXT/test \
#  --destdir $data_bin_path --workers 16 \
#  --srcdict /apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/Exp/CSL/data/databin/zh_xx_2/dict.zh.txt \
#  --tgtdict /apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/Exp/CSL/data/databin/zh_xx_2/dict.xx.txt \
#
#### For Gloss 2 Text
fairseq-preprocess --source-lang xx --target-lang zh \
  --trainpref $TEXT/train --validpref $TEXT/valid \--testpref $TEXT/test \
  --destdir $data_bin_path --workers 16 \
#  --srcdict /apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/Exp/CSL/data/databin/xx_zh/dict.xx.txt \
#  --tgtdict /apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/Exp/CSL/data/databin/xx_zh/dict.zh.txt \
#


#  --srcdict /apdcephfs/share_916081/translation/jinhui/Gloss_to_Text/DSL.data_word/data_bin/xx_de_G30k_T5_newDict/dict.xx.txt \
#  --tgtdict /apdcephfs/share_916081/translation/jinhui/Gloss_to_Text/DSL.data_word/data_bin/xx_de_G30k_T5_newDict/dict.de.txt \
#
#
#


#cd /apdcephfs/share_916081/translation/mt_sys/system_training/jizhi_workspace_jinhui/ZhEn/pytorch-nmt-master
#python3.7 preprocess.py -source_lang xx -target_lang de \
#  -trainpref $TEXT/train -validpref $TEXT/valid -testpref $TEXT/test \
#  -destdir $data_bin_path -workers 64 \
#  -srcdict /apdcephfs/share_916081/translation/jinhui/Gloss_to_Text/DSL.data_word/data_bin/xx_de/dict.xx.txt \
#  -tgtdict /apdcephfs/share_916081/translation/jinhui/Gloss_to_Text/DSL.data_word/data_bin/xx_de/dict.de.txt \
#  -dataset_impl mmap

#python3.7 preprocess.py -source_lang xx -target_lang de \
#  -trainpref $TEXT/train -validpref $TEXT/valid -testpref $TEXT/test \
#  -destdir $data_bin_path -workers 64 \
#  -tgtdict /apdcephfs/share_916081/translation/jinhui/Gloss_to_Text/DSL.data_word/data_bin/dict.xx.txt \
#  -dataset_impl mmap

#export PATH=/apdcephfs/share_916081/jinhuiye/Environments/Python/python3.7.2/bin/:$PATH
#cd /apdcephfs/share_916081/translation/mt_sys/system_training/jizhi_workspace_jinhui/ZhEn/pytorch-nmt-master
#python3.7 preprocess.py -source_lang xx -target_lang de \
#  -trainpref $TEXT/train -validpref $TEXT/valid -testpref $TEXT/test \
#  -destdir $data_bin_path -workers 64 \
#  -dataset_impl mmap

