
data_raw_path=./PGen/G2T/ASL/data
mkdir -p $data_raw_path
cd $data_raw_path
times=40



sys_data=./PGen/G2T/ASL/data/generatedata 

#cp train.en.real train.en
#cp train.xx.real train.xx

TEXT=$data_raw_path

Mode=xx_en_GPT_${times}Times

data_bin_path=./PGen/G2T/ASL/data/data_bin/${Mode}



#pip list | grep fairseq
#if [ $? != 0 ]; then
#  echo 'Install Fairseq First'
#  pip install --editable ./
#fi






cd ./fairseq_old
export PATH=./Envs/anaconda3/envs/PGEN/bin/:$PATH
#nobpe=$path/test.output
#### TDOD for Text 2 Gloss
#fairseq-preprocess --source-lang de --target-lang xx \
#  --trainpref $TEXT/train --validpref $TEXT/valid \--testpref $TEXT/test \
#  --destdir $data_bin_path --workers 16 \
#  --srcdict /apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/ASL.data_word/data_bin/de_xx/dict.en.txt \
#  --tgtdict /apdcephfs/share_916081/jinhuiye/Temp/Gloss_to_Text/ASL.data_word/data_bin/de_xx/dict.xx.txt \
##
### For Gloss 2 Text
fairseq-preprocess --source-lang xx --target-lang en \
  --trainpref $TEXT/train --validpref $TEXT/valid \--testpref $TEXT/test \
  --destdir $data_bin_path --workers 16 \
  --srcdict ./PGen/G2T/ASL/data/data_bin/xx_en/dict.xx.txt \
  --tgtdict ./PGen/G2T/ASL/data/data_bin/xx_en/dict.en.txt \
