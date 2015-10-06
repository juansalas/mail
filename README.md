## Mail by Invision

This iOS app has been built using the prototype "Mail by Invision" as inspiration. The prototype can be found at [https://invis.io/YV3Y3C8D6](https://invis.io/YV3Y3C8D6)

## Installation

Open Mac's Terminal app and run the following commands:

1. Let's clone the repo.
```
git clone https://github.com/juansalas/mail.git DESTINATION_FOLDER
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
