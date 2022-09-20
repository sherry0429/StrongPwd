# strong_pwd

A cross platform tool to create strong password by user defined information, create by flutter.

| Platform      | Supported |  Tested |
| ----------- | ----------- | --------- |
| windows      | yes       |   yes        |
| android   | yes        |  yes         |
| ios   | yes        |  no         |
| os_x   | yes        |  no         |
| linux   | yes        |  no         |

## Warning

$${\color{red}Don't \space use \space it \space on \space other \space people \space computers !}$$

$${\color{red}Don't \space let \space anyone \space know \space your \space computers' unlock password}$$

__otherwise they could delete pin file, backup other file and restart program, across pin verify see your all password.__


this security issues will be solved on next release.


![intro](/videos/strong_pwd_intro.gif)

## Why to use it

Sometime i have to process two questions below:
    1. Account must be change password every 3 or 6 months.
    2. I need to register a new account to avoid likes recommendations
Everytime i changed or create new __safe__ password, it's make my mind like a storm.

If you have same question like me, this tool maybe help you.

## How to use it

1. input your pin code when first start.
![PIN](/imgs/pin.png "pin code")
2. click Name and Description to input anything you want.
![NAMEDESC](/imgs/name_desc_btn.png "name desc")
![NAMEDESCINPUT](/imgs/input.png "name desc input")
3. open your account changed & register web page and copy webpage url
![addweb](/imgs/add_btn.png "add web")
4. paste it to this tool, and click 'save'
![website](/imgs/save_website.png "website")
5. click listview which named like your url, password will be copied to clipboard
![copied](/imgs/secret_copied.png "copied")
6. paste your password to anywhere you want.

By the way, step.4, it could use any information to save, for example, you could use three types of web page like below:
    1. https://test.com
    2. test.com
    3. this is account for test.com website

This info just to make you know, which item in list is password you need copied.

## Security for this tool

1. This tool is fully locally, it can't send any request to internet, so your all data locate on your device.
2. This tool not save any account name, it just save name & desc & url and it's create time information, password only generated when click, it not be saved.
3. This tool's data like name & desc etc, is encrypted and stored on your device, use AES method.
4. PIN code use MD5, one hand encrypted.
5. __If pin code file be deleted, all data will be removed.__[you could use this to reset pin if you forget, but data can not be recover.]
6. Password only created when click, and it at least include upper / lower letters and special signs.

## Data saved dir

__this will changed in next version__

file_lists:
1. content.txt
2. desc.txt
3. pin.txt

| Platform      | file_dir |
| ----------- | ----------- |
| windows      | C:\Users\{username}\Documents   | 
| android   |         |
| ios   |         |
| os_x   |         |
| linux   |         |


## Suggestions

1. __If you are flutter developer, you should changed AES sign and rebuild your own application, it will have more security.__
2. __Don't use simple web url to paste, like www.google.com, it maybe same with others. better choice is use url on register page, most web service will generate unique page for register to trick user data.__
3. __Don't copy file to other platform, use sms login by phone, use this for computer login, is better way.__
4. __Don't put all your secret here, it should only saved password which updated many times or password not important__
5. __Don't use this on other people's device!__


## End

this software is free, if it help you, please give me your stars. thanks.


