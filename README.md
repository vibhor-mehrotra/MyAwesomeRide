# MyAwesomeRide

MyAwesomeRide is a simple application that shows cars in List and Map.


## Requirements

Devices: iPhone
iOS Versions: iOS 15.0 and later


## External Dependencies

None
 

## Architechture

I have used a custom MVVM architechture for this project. It is slightly different from vanilla MVVM as it also has a wireframe file to help routing. The reason I added the wireframe file is because i did not want to pile up my SceneDelegate file with ViewController initialisation code.


## Folder Strcuture

      -- MyAwesomeRide
         -- Model
         -- View
         -- ViewModel
         -- WireFrame
         -- Network
         -- Utility
    
## Highlights

1. Used async await construct for making making network calls in NetworkServices and UIImageview+ImageServices
 
        
        
## FAQ

Q: What does SUT stand for in Unit test?
A: SUT stands for System Under Test.


Q: Instead of directly using data(from: url) method of URLSession from two different places, why did you not use NetworkServices from within UIImageview+ImageServices to fetch image from URL?
A: Because I have created UIImageview+ImageServices as a reusable extension over ImageView and don't wish to tie it to a specific project. I could have injected NetworkServices() inside this extension but then it won't be easily reusable and we would have to always make sure that we inject a concrete implementation of NetworkServicesProtocol.

If we plan on exporting this extension as a third party, this implementation would make it easy to use for all stakeholders 



## Improvements and Next Steps

1. I tried to add NetworkServices unit test as well but the mocking with custom URLProtocol does not seem to work with async version of URLSession's dataTask method. This approach works perfectly fine with older version of this method that uses completion handler though.
    For this reason, I have removed them for now. But in future, if I have more time to invest in
    this, I can try to figure this out and add test cases for Networkservices.
    
2. I have tried to use the best possible placeholder Image for car but I was not able to find the png image that I was looking for on internet and had to use low quality alternative. If I could get a better looking placeholder image, user experience could be far better
    
 
