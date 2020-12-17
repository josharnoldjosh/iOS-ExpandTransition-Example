# iOS Expand Image Transition Example
An example of a image expand transition between view controllers implementing the UIViewControllerTransitioningDelegate.

## Demo
![Demo](demo.gif)  

Here's a demo. Please check out the code to see how its implemented!

## Notes
The project is written in Swift. When the image expands, it actually transitions to a new view controller. The view controller can be "panned" and dragged to be dismissed. There is also attention to detail, the background "dims" slightly black, and the corners are rounded. Despite involving a pan gesture, this is not explicitly an "interactive" transition. Below is an image of the architecture.  

![Example](example)  