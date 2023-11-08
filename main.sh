#!/bin/bash

echo "Different action will be asked to help you train a simple dataset."
# echo "Only write the needed parameters"

main()
{
    f_dataset()
    {
        echo "On witch dataset would you like to train the models ? Available datasets are cifar/mnist/fashionmnist/mvtec/paris." # dataset
        read dataset

        if [ -z "$dataset" ]
        then
            echo empty
            dataset=cifar
        fi
        echo "Choosen dataset : " $dataset

            echo "Confirm dataset ? [yes/no]"
        read data_conf

        if [[ $data_conf != *"y"* ]]
        then
            f_dataset
        fi
    }
    f_dataset





    # FIXME : Need to add elements of confirmation for each elements

    echo "Do you want default values to train this dataset ? [yes/no] (If yes, no more question will be asked and the training of the selected dataset will start)"
    read train_instant

    if [[ $train_instant == *"y"* ]]
    then
        python main_train.py  --num_images 1  --pos_class plane --index_download 0 --dataset $dataset
    else
        echo No
    fi

}

main

