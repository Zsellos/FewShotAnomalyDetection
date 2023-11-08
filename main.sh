#!/bin/bash

echo "Different action will be asked to help you train a simple dataset."
# echo "Only write the needed parameters"

echo "First, on witch dataset would you like to train the models ? Available datasets are cifar/mnist/fashionmnist/mvtec/paris." # dataset
read dataset
echo "Chosen dataset : " $dataset

echo "Do you want default values to train this dataset ? [yes/no] (If yes, no more question will be asked and the training of the selected dataset will start)"
read train_instant

if [[ $train_instant == *"yes"* ]]
then
    python main_train.py  --num_images 1  --pos_class plane --index_download 0 --dataset $dataset
else
    echo No
fi

read -p "Enter your name: " name
echo Hello $name!

# python main_train.py  --num_images <num_training_images>  --pos_class <normal_class_in_dataset> --index_download <index_of_training_image> --dataset $dataset


# --min_size                  image minimal size at the coarser scale (default 25)
# --max_size                  image minimal size at the coarser scale (default 64)
# --niter                     number of iterations to train per scale
# --num_images                number of images to train on (1,5,10 in the paper)
# --size_image                the original image size 
# --fraction_defect           the number of patches to consider in defect detection (recommended arguments: 0.01-0.1)
# --pos_class                 the normal class to train on
# --dataset                   paris/cifar/mnist/fashionmnist/mvtec
# --random_images_download    "True" if training random images from the normal class (otherwise, specify the index of the training image in --index_download)
# --devices_ids                for 10shot we have used --device_ids = 0 1     