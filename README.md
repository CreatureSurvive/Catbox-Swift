# Catbox-Swift

Catbox-Swift is a library for uploading files to the [CatBox.moe](https://catbox.moe) website. 

## Features

* Upload single or multiple files from local URLs
* Upload single or multiple files from remote URLs
* Upload files from their `Data` representation
* Delete files from the website
* Create albums
* Edit albums
* Delete albums

## Usage

#### Upload Files

```swift
let imageUrl1 = URL(fileURLWithPath: "/path/to/my/local/file.jpeg")!
let imageUrl2 = URL(string: "https://example.xyz/path/to/my/remote/file.jpeg")!
let uploadRequest = CatboxFilesUploadRequest(
    userhash: "###", // optional userhash, if left nil, the files will be uploaded anonymously
    files: [ imageUrl1, imageUrl2 ]
)
let urls: [URL] = try await CatboxClient.sharedClient.request(uploadRequest)
```

#### Delete Files

```swift
let deleteRequest = CatboxDeleteFilesRequest(
    userhash: "###", // userhash is required for deleting files
    files: ["ax5f01.jpeg"]
)
let response: String = try await CatboxClient.sharedClient.request(deleteRequest)
```

#### Other Request Types

* `CatboxDeleteFilesRequest`
* `CatboxFilesUploadRequest`
* `CatboxFileDataUploadRequest`
* `CatboxLocalURLUploadRequest`
* `CatboxURLUploadRequest`
* `CatboxCreateAlbumRequest`
* `CatboxEditAlbumRequest`
* `CatboxAddToAlbumRequest`
* `CatboxRemoveFromAlbumRequest`
* `CatboxDeleteAlbumRequest`
* `CatboxUploadAndCreateAlbum`

