<h1 align="center">FDJ-Tech-Test</h1>
iOS developer technical Interview for FDJ
<p align="center">
  <a href="https://upload.wikimedia.org/wikipedia/commons/4/45/IOS_14_Logo.png"><img alt="ios" src="https://upload.wikimedia.org/wikipedia/commons/4/45/IOS_14_Logo.png"/></a>
</p>

## Implementation

### Contraints
> 
> Apply good practices
>
> Use MVVM Pattern without RX

## Interface

<p align="center">
  <a href="https://github.com/elaidi93/PSA-Weather/blob/main/Readme_img/screen1.jpeg"><img alt="ios" src="https://github.com/elaidi93/PSA-Weather/blob/main/Readme_img/screen1.jpeg"/></a>
    <a href="https://github.com/elaidi93/PSA-Weather/blob/main/Readme_img/screen2.jpeg"><img alt="ios" src="https://github.com/elaidi93/PSA-Weather/blob/main/Readme_img/screen2.jpeg"/></a>
        <a href="https://github.com/elaidi93/PSA-Weather/blob/main/Readme_img/screen3.jpeg"><img alt="ios" src="https://github.com/elaidi93/PSA-Weather/blob/main/Readme_img/screen3.jpeg"/></a>
</p>

## Architecture 

I used an MVVM architecture for my application. 

![MVVM Architecture](https://upload.wikimedia.org/wikipedia/commons/8/87/MVVMPattern.png "")

I found this architecture pretty well because thanks to it, I can easily test the business logic, and way better to find bugs and clean code

The whole architecture is designed to make each component as independent as possible.

I used also dependency injection for calling viewModels to avoid controller creation an instance object for it, and make it easier to call
And i used Result, async await, Tasks and GCD (Grand Central Dispatch) to handle response in a backround thread

## Unit tests

I used [XCTest](https://developer.apple.com/documentation/xctest) 

## Time Challenge

It tooke me over 12 hours to complete the whole teste, it was pretty easy so i tried to implement the best practice that I've learned during my career.
