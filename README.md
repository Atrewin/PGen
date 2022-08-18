# PGen
## step zero: requestments

pip install [transformers](https://github.com/huggingface/transformers)


## step one: finetuning GPT
You can refer to [transformers-language-modeling](https://github.com/huggingface/transformers/tree/main/examples/pytorch/language-modeling) to finetuning a pre-trained GPT.
Simply, you also can edit and `bash finetuning_GPT.sh` by your path.

## step two: generate in-domain data
You can edit and `bash generate_in_domain_sentences.sh` to get monolingal data. The code is based on [OpenAI GPT2](https://huggingface.co/docs/transformers/model_doc/gpt2)

## step three: train translation model

You can follow [fairseq](https://github.com/facebookresearch/fairseq) or [mT5](https://github.com/google-research/multilingual-t5) to train the translation models (e.g. text-to-gloss or gloss-to-text) 

