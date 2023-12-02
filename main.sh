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


    f_dataset() {
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

    train_or_test() {
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

    f_label() {
        if [[ $dataset -eq "cifar" ]]
        then 
            labels="airplane/automobile/bird/cat/deer/dog/frog/horse/ship/truck"
        fi
        if [[ $dataset -eq "mnist" ]]
        then 
            labels="numbers from 0 to 9"
        fi
        if [[ $dataset -eq "fashionmnist" ]]
        then 
            labels="numbers from 0 to 9 (corresponding to a type of clothing)"
        fi
        if [[ $dataset -eq "paris" ]]
        then 
            labels="defense/eiffel/invalides/louvre/moulinrouge/museedorsay/notredame/pantheon/pompidou/sacrecoeur/triomphe"
        fi
        if [[ $dataset -eq "mvtec" ]]
        then 
            labels="adapter_plate_square/adapter_plate_triangular/box/bracket_big/bracket_planar/bracket_screw/cap/car_rim/..."
        fi

        echo "On which label do you want to train ? Available label for $dataset are $labels"
        read label

        if [ -z "$label" ]
        then
            if [[ $dataset == "cifar" ]]
            then 
                label="cat"
            elif [[ $dataset == "mnist" ]]
            then 
                label="0"
            elif [[ $dataset == "fashionmnist" ]]
            then 
                label="0"
            elif [[ $dataset == "paris" ]]
            then 
                label="defense"
            elif [[ $dataset == "mvtec" ]]
            then 
                label="adapter_plate_square"
            else
                label=0
            fi
        fi
        echo "Random image : " $random

        echo "Confirm ? [yes/no]"
        read data_conf

        if [[ $data_conf != *"y"* && $data_conf != "" ]]
        then
            random_img
        fi
        echo "Image choosen at random =" $random_img

    }

    random_img() {
        echo "Do you want to train on a specific images or on random ?"
        read random

        if [ -z "$random" ]
        then
            # echo empty
            random=True
        fi
        echo "Random image : " $random

        echo "Confirm ? [yes/no]"
        read data_conf

        if [[ $data_conf != *"y"* && $data_conf != "" ]]
        then
            random_img
        fi
        echo "Image choosen at random =" $random_img
    }

    f_image_idx() {
        echo "On which index the image have to be found ?"
        read idx

        if [ -z "$idx" ]
        then
            idx=1
        fi
        echo "Index : " $idx

        echo "Index =" $idx "Confirm ? [yes/no]"
        read data_conf

        if [[ $data_conf != *"y"* && $data_conf != "" ]]
        then
            f_image_idx
        fi
        echo "Index  :" $idx
    }

    f_niter() {
        echo "Number of iteration in each scales ? (for example : 1000)"
        read niter

        if [ -z "$niter" ]
        then
            niter="1000"
        fi
        echo "Number of iteration : " $niter

        echo "Confirm ? [yes/no]"
        read data_conf

        if [[ $data_conf != *"y"* && $data_conf != "" ]]
        then
            f_niter
        fi
        echo "Number of iteration :" $niter
    }

    f_test_size() {
        echo "Test size ? (ex : 10000)"
        read test_size

        if [ -z "$test_size" ]
        then
            test_size="10000"
        fi
        echo "Test size : " $test_size

        echo "Confirm ? [yes/no]"
        read data_conf

        if [[ $data_conf != *"y"* && $data_conf != "" ]]
        then
            f_test_size
        fi
        echo "Test Size :" $test_size
    }
    
    f_defect() {
        echo "Fraction of patches to consider in each scale ? (ex : 0.1)"
        read fraction_defect

        if [ -z "$fraction_defect" ]
        then
            fraction_defect="0.1"
        fi
        echo "Fraction of patches to consider : " $fraction_defect

        echo "Confirm ? [yes/no]"
        read data_conf

        if [[ $data_conf != *"y"* && $data_conf != "" ]]
        then
            f_defect
        fi
        echo "Fraction of patches :" $fraction_defect
    }

    f_size_image() {
        echo "Size of the images ? (ex : 128)"
        read fraction_defect

        if [ -z "$size_image" ]
        then
            size_image="128"
        fi
        echo "Image size : " $size_image

        echo "Confirm ? [yes/no]"
        read data_conf

        if [[ $data_conf != *"y"* && $data_conf != "" ]]
        then
            f_defect
        fi
        echo "Image Size :" $size_image
    }

    f_device_id() {
        echo "Device ID ?"
        read device_ID

        if [ -z "$device_ID" ]
        then
            device_ID="0"
        fi
        echo "Device ID : " $device_ID

        echo "Confirm ? [yes/no]"
        read data_conf

        if [[ $data_conf != *"y"* && $data_conf != "" ]]
        then
            f_device_id
        fi
        echo "Device ID :" $device_ID
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

    not_default() {
        f_label
        random_img
        if [[ $random != "True" ]]
        then
            f_image_idx
        fi
        f_niter
        f_test_size
        f_image_idx

        fraction_defect="0.1"
        if [[ $dataset == "mvtec" ]]
        then
            f_defect
        fi

        f_size_image
        f_device_id

        other_parameters

        python main_train.py  --num_images $num_images --pos_class $label --index_download $index_download --dataset $dataset --mode $trts  --niter_gray $niter --niter_rgb $niter --test_size $test_size --size_image $size_image --device_ids $device_ID $op # --fraction_defect $fraction_defect
    }

    default() {
        if [[ $dataset == "cifar" ]]
        then
            label=cat
        fi
        if [[ $dataset == "mnist" ]]
        then
            label=0
        fi
        if [[ $data_conf == "fashionmnist" ]]
        then
            label=0
        fi
        if [[ $dataset == "paris" ]]
        then
            label=defense
        fi
        if [[ $dataset == "mvtec" ]]
        then
            label=0
        fi
        python main_train.py  --num_images $num_images  --pos_class $label --index_download $index_download --dataset $dataset --mode $trts
    }




    # FIXME : Need to add elements of confirmation for each elements

    echo "Do you want default values to train this dataset ? [yes/no] (If yes, no more question will be asked and the training of the selected dataset will start)"
    read train_instant

    if [[ $train_instant == *"y"* && $train_instant != "" ]]
    then
        default # python main_train.py  --num_images $num_images  --pos_class $label --index_download $index_download --dataset $dataset
    else
        not_default
    fi


    
    results() {
        cat $dataset*$num_images*$label*.txt
    }
    results

    

}
main

