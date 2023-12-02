#!/bin/bash

echo "Different action will be asked to help you train a simple dataset."
# echo "Only write the needed parameters"

main()
{
    # default values :
    dataset=cifar
    num_images=1
    label=plane
    index_download=1


    f_dataset()
    {
        echo "On witch dataset would you like to train the models ? Available datasets are cifar/mnist/fashionmnist/mvtec/paris." # dataset
        read dataset

        if [ -z "$dataset" ]
        then
            # echo empty
            dataset=cifar
        fi
        echo "Choosen dataset : " $dataset

        echo "Confirm dataset ? [yes/no]"
        read data_conf

        if [[ $data_conf != *"y"* && $data_conf != "" ]]
        then
            f_dataset
        fi
        echo $dataset "had been choosen."
    }
    f_dataset

    f_num_images() {
        echo "How many images to you want to train on ?" # num_images
        read num_images

        if [ -z "$num_images" ]
        then
            # echo empty
            num_images=1
        fi
        echo "Number images for training : " $num_images

            echo "Confirm number of images ? [yes/no]"
        read data_conf

        if [[ $data_conf != *"y"* && $data_conf != "" ]]
        then
            f_num_images
        fi
        echo "number of images :" $num_images
    }
    f_num_images

    train_or_test()
    {
        echo "Do you want to train or test ?"
        read trts

        if [ -z "$trts" ]
        then
            # echo empty
            trts=train
        fi
        echo "Train or Test ? : " $trts

            echo "Confirm ? [yes/no]"
        read trts_conf

        if [[ $trts_conf != *"y"* && $trts_conf != "" ]]
        then
            train_or_test
        fi
        echo $trts
    }
    train_or_test

    not_default()
    {
        echo no default
    }

    default()
    {
        if [[ $data_conf -eq "cifar" ]]
        then
            label=cat
        fi
        if [[ $data_conf -eq "mnist" ]]
        then
            label=0
        fi
        if [[ $data_conf -eq "fashionmnist" ]]
        then
            label=0
        fi
        if [[ $data_conf -eq "paris" ]]
        then
            label=defense
        fi
        if [[ $data_conf -eq "mvtec" ]]
        then
            label=0
        fi
        python main_train.py  --num_images $num_images  --pos_class $label --index_download $index_download --dataset $dataset --mode $trts
    }

        other_parameters() {
        echo "Do you want to add other parameters ? If yes, add here all the other parameters you need in the form --[parameter] [content]"
        read op
        if [ -z "$op" ]
        then
            # echo empty
            op=""
        fi
        echo "Parameters added : " $op

        echo "Confirm ? [yes/no]"
        read op_conf

        if [[ $op_conf != *"y"* && $op_conf != "" ]]
        then
            other_parameters
        fi
    }


    # FIXME : Need to add elements of confirmation for each elements

    echo "Do you want default values to train this dataset ? [yes/no] (If yes, no more question will be asked and the training of the selected dataset will start)"
    read train_instant

    if [[ $train_instant == *"y"* && $train_instant != "" ]]
    then
        default # python main_train.py  --num_images $num_images  --pos_class $label --index_download $index_download --dataset $dataset
    else
        not_default
        other_parameters
    fi


    
    results() {
        cat $dataset*$num_images*$label*.txt
    }
    results

    

}
main


