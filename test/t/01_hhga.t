#!/usr/bin/env bash

BASH_TAP_ROOT=../deps/bash-tap
. ../deps/bash-tap/bash-tap-bootstrap

PATH=../bin:$PATH # for vg

export LC_ALL="C" # force a consistent sort order 

plan tests 3

hhga -h 2>/dev/null
is $? 0 "hhga help runs"

is $(hhga -b minigiab/NA12878.chr22.tiny.bam -f minigiab/q.fa -v minigiab/NA12878.chr22.tiny.giab.vcf.gz -t -r q:10502-10562 | md5sum | cut -f 1 -d\ ) 4f18fe3f91269f7117d67faf241ee80c "expected output produced for a test region"

is $(hhga -b minigiab/NA12878.chr22.tiny.bam -f minigiab/q.fa -v minigiab/NA12878.chr22.tiny.giab.vcf.gz -r q:10502-10562 -c 1 | md5sum | cut -f 1 -d\ ) aad2e4cd68d21b8b3b9405993bbdbbaa "expected vw-format output produced for a test region"
