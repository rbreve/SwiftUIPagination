
# SwiftUI Pagination with Cube Effect

![](https://raw.githubusercontent.com/rbreve/SwiftUIPagination/master/demo.gif)


Let's you create pagination with a 3D effect like the instagram stories  


## Usage

###### Create your custom view

```
struct Page: View {
    var imageName = "photo1"
    var imageTitle: String?
    
    var body: some View {
           GeometryReader { proxy in
                 VStack {
                    Image(self.imageName)
                         .resizable()
                         .frame(width: proxy.size.width)
                         .aspectRatio(contentMode: .fit)
                     
                    Text(self.imageTitle ?? "")
                         .fontWeight(.black)
                 }
        }
    }
}
```

######  Create a data source for each view

```
struct PageData : Identifiable {
    var id = UUID()
    var imageName : String
    var imageTitle : String
}
```

###### Call PaginationView with your data and View.


```

struct ContentView: View {
    // Create your pages 
    let pages = [PageData(imageName: "photo1", imageTitle: "Helsinki"), PageData(imageName: "photo2", imageTitle: "Boats"), PageData(imageName: "photo3", imageTitle: "River Dock")]
    
    var body: some View {
        PaginationView(pages: pages) { page in
            //Page is just a View with content
            Page(imageName: page.imageName, imageTitle: page.imageTitle)
        }
    }
}
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
