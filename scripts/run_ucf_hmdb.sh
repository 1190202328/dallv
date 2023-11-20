## source_model
#tag="source_training"
#CUDA_VISIBLE_DEVICES=0 /home/luban/apps/miniconda/miniconda/envs/torch1101/bin/python -W ignore src/train.py \
#  experiment=ucf_hmdb \
#  datamodule.batch_size=24 \
#  model.loss.source.weight=1.0 \
#  model.domain_shift=True \
#  datamodule.domain_shift=True \
#  datamodule.im2vid=True \
#  model.prompts.type=original \
#  model.prompts.eval=original \
#  model.network.pretrained_model=none \
#  model.network.sim_header=meanP \
#  model.network.fusion_input=logits \
#  model.network.use_adapter=True \
#  model.network.arch=RN50 \
#  model.validation_adapter=source \
#  tags=[$tag] \
#  logger.wandb.tags=[$tag] \
#  logger.wandb.project=dallv_sports_da \
#  trainer.max_epochs=30 \
#  trainer.devices=1
#
## target model
#tag="target_training"
#CUDA_VISIBLE_DEVICES=0 /home/luban/apps/miniconda/miniconda/envs/torch1101/bin/python -W ignore src/train.py \
#  experiment=ucf_hmdb \
#  datamodule.batch_size=24 \
#  model.loss.source.weight=0.0 \
#  model.loss.target.weight=1.0 \
#  model.domain_shift=True \
#  datamodule.domain_shift=True \
#  datamodule.im2vid=True \
#  model.prompts.type=original \
#  model.prompts.eval=original \
#  model.network.pretrained_model=none \
#  model.network.sim_header=meanP \
#  model.network.fusion_input=logits \
#  model.network.use_adapter=True \
#  model.network.arch=RN50 \
#  model.validation_adapter=target \
#  tags=[$tag] \
#  logger.wandb.tags=[$tag] \
#  logger.wandb.project=dallv_sports_da \
#  trainer.max_epochs=30 \
#  trainer.devices=1

# method
tag="dallv"
CUDA_VISIBLE_DEVICES=0 /home/luban/apps/miniconda/miniconda/envs/torch1101/bin/python -W ignore src/train.py \
  experiment=ucf_hmdb \
  model.network.source_adapter_checkpoint=ckpt/ucf_hmdb_source_model.ckpt \
  model.network.target_adapter_checkpoint=ckpt/ucf_hmdb_target_model.ckpt \
  datamodule.batch_size=4 \
  model.loss.source.weight=1.0 \
  model.loss.temperature=2.0 \
  model.domain_shift=True \
  datamodule.domain_shift=True \
  datamodule.im2vid=True \
  model.prompts.type=original \
  model.prompts.eval=original \
  model.network.pretrained_model=none \
  model.network.sim_header=meanP \
  model.network.fusion_input=logits \
  model.network.use_adapter=True \
  model.network.arch=RN50 \
  model.distillation=True \
  tags=[$tag] \
  logger.wandb.tags=[$tag] \
  logger.wandb.project=dallv_sports_da \
  trainer.devices=1 \
  trainer.max_epochs=30