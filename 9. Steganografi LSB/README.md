# Matlab Grayscale Steganography 
[![Twitter Badge](https://img.shields.io/badge/chat-twitter-blue.svg)](https://twitter.com/ArrayLikeObj)
[![GitHub license](https://img.shields.io/github/license/ethanny2/matlab-grayscale-steganography)](https://github.com/ethanny2/matlab-grayscale-steganography/blob/master/LICENSE)

<div align="center">
  <img  src="https://media.giphy.com/media/fvH4otHpsK6ZKS4E6B/giphy.gif" alt="Gif of script in action">
</div>

## Requirements
+ A program to execute .m scripts such as Matlab or the free alternative [GNU Octave](https://www.gnu.org/software/octave/).
+ Only works on [.bmp files](https://www.paintshoppro.com/en/pages/bmp-file/)
+ Only works on grayscale images; although to work with color photos its an easy change to multiply the returned array by 3 (# RGB channels)

## Usage
+ secret_message.txt: Contains the secret message you wish to embed in the target .bmp (bitmap) image.
+ encode.m : The main matlab script that utilizes the Least Significant bit algorithm to slightly alter the color channels of the target .bmp file; padding each pixel with an additional number of bytes that comprise the secret message.
    + Limitation: Size of message (in bits ) cannot exceed the (# of pixels * in your target .bmp photo)* 3. 
  + 1 pixel = 8 bits
  + #of pixels = image width * height 
  + Outputs: encodedImg.bmp with your hidden message

``` 
    encode.m

    % Put in path to the image you want to encode
    c = imread('[YOUR_PATH_HERE]\images\earth.bmp');

    % Put in path to secret_message.txt file you want to put encode in image
    id = fopen('[YOUR_PATH_HERE]\secret_message.txt', 'r');

    .
    .
    .

    % write the new image with the hidden image in it to 's' or disk.
    imwrite(s,'[YOUR_PATH_HERE]\encodedImg.bmp','bmp'); 
```
+ decode.m:
+ Gets the least significant bit of each pixel in the encodedImg.bmp and combines it to form a binary number then convert to a string.
  + Outputs secret message in file called: decodedMessage.txt
```
    decode.m

    % Put in path to the encoded image that was the result of encode.m
    s= imread('[YOUR_PATH_HERE]\encodedImg.bmp');

    .
    .
    .

    % Put in path to where you want to save the decodedMessage.txt file
    id = fopen('[YOUR_PATH_HERE]\decodedMessage.txt','w');

```
  
  [Source](https://www.boiteaklou.fr/Steganography-Least-Significant-Bit.html)
![LSB algorithm principle](https://i.gyazo.com/a72d0702c3f880ca9fe87bf302b2801d.png "Sample image")



## Concepts and Languages Used
+ Matlab scripting language because it can easily manipulate raw image data and work with lower-level concepts like binary.Python could have also been used to solve this.
+ LSB Algorithm: Changing the least significant bit in a binary number is a replacement that overall doesn't largely affect the overall appearance of an image allowing this to be a perfect encoding algorithm.
+ Decoding is simple if you know the algorithm used to encode the picture.
