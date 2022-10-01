
# PGen: Scaling Back-Translation with Domain Text Generation for Sign Language Gloss Translation

Implementation of our paper "Scaling Back-Translation with Domain Text Generation for Sign Language Gloss Translation" 


## Brief Introduction
Sign language gloss translation aims to translate the sign glosses into spoken language texts, which is challenging due to the scarcity of labeled gloss-text parallel data.  To alleviate this problem, previous studies augment synthetic gloss-text parallel data with back-translation(**BT**), which translates in-domain monolingual texts into sign gloss annotations. However, it is very difficult to obtain large-scale in-domain monolinguals through web crawling and retrieval due to special domain characteristics in sign language. The lack of in-domain monolingual text data limits the effect of synthetic parallel data. The **P**rompt based domain text **Gen**eration (**PGen**) overcomes the limitation by producing large-scale in-domain monolingual text data based on the text side of the originally small-scale gloss-text parallel data. Specifically, PGen randomly concatenates sentences from the original  monolingual text dataset as prompts to induce a pre-trained language model (i.e., GPT-2) to generate sentences in similar styles. Our analysis experiments show that the generated monolingual texts are more similar to the original monolingual texts in word distribution than the texts retrieved from the general domain data. Experimental results on three benchmarks of sign language gloss translation in varied languages demonstrate that augment monolingual texts generated by PGen can  significantly impromve the BT, especially scaling BT. 

<div align="center">
    <img src="/image/framework.jpg" width="70%" title="Framework of Prompt based domain text Generation."</img>
    <p class="image-caption">Figure 1: Framework of prompt based domain texts generation.</p>
</div>


## Reference Performance
We conduct both intrinsic and extrinsic evaluations for the proposed PGen approach.

### 1. Intrinsic Evaluations
**A) The word frequencies for the four monolingual corpus which gained by different methods.**


<div align="center">
    <img src="/image/word_distribution.jpg" width="50%" title="Framework of Self-training with Uncertainty-Based Sampling."</img>
    <p class="image-caption">Figure 2: The word frequency distribution on different types of monolingual corpora. The X-axis represents different words, while the Y-axis represents word frequency.</p>
</div>

### 2. Extrinsic Evaluations

**B) The performance of the gloss-to-text translation task when scaling the used monolingual data from our PGen and the retrieved approa** 
<div align="center">
    <img src="/image/bleu_vs_scale.jpg" width="50%" title="Framework of Self-training with Uncertainty-Based Sampling."</img>
    <p class="image-caption">Figure 3: The translation performance of back-translation when scaling the used monolingual data from our PGen and the retrieved approach. The red dashed line denotes the baseline model without back-translation. Best viewed in color. </p>
</div>


**C) The performance of Gloss-to-text translation on Phoenix2014T, CSL-daily and ASLG-PC12.**

<div align="center">
    <img src="/image/gloss_text.jpg" width="70%" title="Framework of Self-training with Uncertainty-Based Sampling."</img>
    <p class="image-caption">Table 1: Gloss-to-text translation performance on Phoenix2014T, CSL-daily and ASLG-PC12.</p>
</div>


## Implementation

### 1. Installation
This code is based on [transformers](https://github.com/huggingface/transformers) for PGen and [fairseq](https://github.com/facebookresearch/fairseq) for gloss-to-text translation. You can follow their pages to install. 


### 2. Finetuning GPT
You can refer to [transformers-language-modeling](https://github.com/huggingface/transformers/tree/main/examples/pytorch/language-modeling) to finetuning a pre-trained GPT. Simply, you also can follow our script `bash finetuning_GPT.sh` to quick start.

### 3.  In-domain Data Generation

You can follow the documents of [OpenAI GPT2](https://huggingface.co/docs/transformers/model_doc/gpt2) to generate the sentences. Also, we give a script `bash generate_in_domain_sentences.sh` to support. 



There, we give a large in-domain monolingual texts for SLT tasks (Phoenix2014T, CSL-daily and ASLG-PC12). 

You can find them in `data/PGen_monolingual/*` and get a quick start when apply scaling BT to sign language translation.


### 4. Get result on sign language  gloss translation

You can follow [fairseq](https://github.com/facebookresearch/fairseq) or [mT5](https://github.com/google-research/multilingual-t5) to train the translation models (e.g. text-to-gloss or gloss-to-text) 



