<h1>Basic CATransitions</h1>

Custom pushviewcontroller animations with CATransition

```Swift
    let type: [CATransitionType] = [.fade, .push, .reveal, .moveIn]
    let timingFunctions: [CAMediaTimingFunctionName] = [.default, .linear, .easeOut, .easeIn, .easeInEaseOut]
    let subType: [CATransitionSubtype] = [.fromTop,.fromLeft,.fromRight,.fromBottom]
    let fillMode: [CAMediaTimingFillMode] = [.forwards, .backwards, .both, .removed]
    let duration: [CFTimeInterval] = [0.1, 0.2, 0.3, 0.4, 0.5, 0.7, 1.0]
``` 

<img src="https://github.com/Winlentia/CATransitionDemo/blob/main/gif/CATransitionDemo.gif" width="414" height="896" />
