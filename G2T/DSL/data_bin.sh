
data_raw_path=./PGen/G2T/phoenix2014T/data
mkdir -p $data_raw_path
cd $data_raw_path
times=40



sys_data=./PGen/G2T/phoenix2014T/data/generating_data/find_best_times #need2.80w.de.clear.5Times.de
cat train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real train.de.real $sys_data/need2.80w.de.clear.${times}Times.de > train.de
cat train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real train.xx.real $sys_data/need2.80w.de.clear.${times}Times.de.T5.gloss > train.xx

#cp train.de.real train.de
#cp train.xx.real train.xx

TEXT=$data_raw_path

Mode=xx_de_GPT_${times}Times

data_bin_path=./PGen/G2T/phoenix2014T/data/data_bin/${Mode}



#pip list | grep fairseq
#if [ $? != 0 ]; then
#  echo 'Install Fairseq First'
#  pip install --editable ./
#fi






cd ./fairseq_old
export PATH=./anaconda3/envs/PGen/bin/:$PATH
#nobpe=$path/test.output
#### TDOD for Text 2 Gloss
#fairseq-preprocess --source-lang de --target-lang xx \
#  --trainpref $TEXT/train --validpref $TEXT/valid \--testpref $TEXT/test \
#  --destdir $data_bin_path --workers 16 \
#  --srcdict /apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/DSL.data_word/data_bin/de_xx/dict.de.txt \
#  --tgtdict /apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/DSL.data_word/data_bin/de_xx/dict.xx.txt \
##
### For Gloss 2 Text
fairseq-preprocess --source-lang xx --target-lang de \
  --trainpref $TEXT/train --validpref $TEXT/valid \--testpref $TEXT/test \
  --destdir $data_bin_path --workers 16 \
  --srcdict ./PGen/G2T/phoenix2014T/data/data_bin/xx_de/dict.xx.txt \
  --tgtdict ./PGen/G2T/phoenix2014T/data/data_bin/xx_de/dict.de.txt \
#


#  --srcdict /apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/DSL.data_word/data_bin/xx_de_G30k_T5_newDict/dict.xx.txt \
#  --tgtdict /apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/DSL.data_word/data_bin/xx_de_G30k_T5_newDict/dict.de.txt \
#
#
#


#cd /apdcephfs/share_916081/translation/mt_sys/system_training/jizhi_workspace_jinhui/ZhEn/pytorch-nmt-master
#python3.7 preprocess.py -source_lang xx -target_lang de \
#  -trainpref $TEXT/train -validpref $TEXT/valid -testpref $TEXT/test \
#  -destdir $data_bin_path -workers 64 \
#  -srcdict /apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/DSL.data_word/data_bin/xx_de/dict.xx.txt \
#  -tgtdict /apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/DSL.data_word/data_bin/xx_de/dict.de.txt \
#  -dataset_impl mmap

#python3.7 preprocess.py -source_lang xx -target_lang de \
#  -trainpref $TEXT/train -validpref $TEXT/valid -testpref $TEXT/test \
#  -destdir $data_bin_path -workers 64 \
#  -tgtdict /apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/DSL.data_word/data_bin/dict.xx.txt \
#  -dataset_impl mmap

#export PATH=/apdcephfs/share_916081/jinhuiye/Environments/Python/python3.7.2/bin/:$PATH
#cd /apdcephfs/share_916081/translation/mt_sys/system_training/jizhi_workspace_jinhui/ZhEn/pytorch-nmt-master
#python3.7 preprocess.py -source_lang xx -target_lang de \
#  -trainpref $TEXT/train -validpref $TEXT/valid -testpref $TEXT/test \
#  -destdir $data_bin_path -workers 64 \
#  -dataset_impl mmap

