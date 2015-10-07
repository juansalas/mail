## Mail by Invision

This iOS app has been built using the prototype "Mail by Invision" as inspiration. The prototype can be found at [https://invis.io/YV3Y3C8D6](https://invis.io/YV3Y3C8D6)

![Inbox View](https://dl.dropboxusercontent.com/u/287658/mail0.png?new)
![Email Thread View](https://dl.dropboxusercontent.com/u/287658/mail1.png?new)

## Requirements
1. Xcode 6.4
2. Git [Follow this guide to install](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
3. CocoaPods [Follow this guide to install](https://guides.cocoapods.org/using/getting-started.html)

## Installation

Open Mac's Terminal app and run the following commands:

1. Create a folder to host the project
```
mkdir FOLDER_NAME
cd FOLDER_NAME
```

2. Let's clone the repo.
```
git clone https://github.com/juansalas/mail.git
```

2. Install the CocoaPods (AFNetworking)
```
pod install
```

3. That's all! Open MailInvision.xcworkspace on Xcode.

## API Configuration

On file MailInvision/Stores/InboxAPI.m there's a reference to the Inbox API endpoint:
```
static NSString * const kGetInbox = @"http://dev.laterous.com/invision/index.php";
```

The code for the index.php can be found at [http://dev.laterous.com/invision/index.txt](http://dev.laterous.com/invision/index.txt). Please feel free to download it and host it your self if required.


## License

Copyright (c) 2015 Juan Ignacio Salas. See LICENSE for further details.
