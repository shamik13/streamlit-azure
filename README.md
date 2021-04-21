## Harry Potter story generator

Given a starting prompt and number of words, a GPT2 model trained on Harry Potter books generates a unique story.
The purpose of this repository is to show a demo of deploying a streamlit app on azure. The website hosted on azure can be accessed here: https://hpst2021awa.azurewebsites.net/ 
## Step by step guide:
- **Step 1**: Finetuning GPT2:
  ```
  >>> mkdir hp_app                                                        ## create project dir 
  >>> cd hp_app                                      
  >>> git clone git@github.com:shamik13/streamlit-azure.git               ## clone this repo
  >>> git clone https://github.com/huggingface/transformers.git           ## clone huggingface/transformers repo
  >>> cd transformers/examples/language-modeling                        
  >>> CUDA_VISIBLE_DEVICES=3, python run_clm.py \                         ## finetune GPT2 on Harry Potter data
  >>>                         --model_name_or_path gpt2 \
  >>>                         --train_file "../../../streamlit-azure/data/book_train.txt" \
  >>>                         --validation_file "../../../streamlit-azure/data/book_test.txt" \
  >>>                         --do_train \
  >>>                         --do_eval \
  >>>                         --output_dir "../../../streamlit-azure/docker/model/" \
  >>>                         --fp16 True
  ```
- **Step 2**: Allocating resources: 
  ```
  >>> az login
  >>> cd streamlit-azure/terraform/envs/dev
  >>> terraform init
  >>> terraform plan
  >>> terraform apply -auto-approve
  ```
 - **Step 3**: Wait for the deployment to finish. Go to Azure portal and open the app service created by terraform. Click on the URL shown in `Overview` tab.
 
  
