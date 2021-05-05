#!/bin/bash

export KALDI_ROOT="/kaldi"
# Setting paths to useful tools
export PATH=$KALDI_ROOT/src/bin:$KALDI_ROOT/tools/openfst/bin:$KALDI_ROOT/src/fstbin/:$KALDI_ROOT/src/gmmbin/:$KALDI_ROOT/src/featbin/:$KALDI_ROOT/src/lmbin/:$KALDI_ROOT/src/sgmm2bin/:$KALDI_ROOT/src/fgmmbin/:$KALDI_ROOT/src/latbin/:$KALDI_ROOT/src/onlinebin/:$PWD:$PATH

while :
do
  # loop infinitely
  online-server-gmm-decode-faster \
    --verbose=1 --rt-min=0.5 --rt-max=3.0 \
    --max-active=6000 --beam=13.0 \
    --acoustic-scale=0.08333 \
    tri2/final.mdl tri2/graph/HCLG.fst \
    tri2/graph/words.txt '1' 5050
    # tri2/graph/phones/word_boundary.int \
    # 5010 
    #\ tri2/final.mdl
done
