# CSVReader

Simple CSV Reader Swift Package

- Supports comma separated values whose rows are separated by newlines and whose fields do not contain commas or newlines.
- Optinoally breaks out headers from values.


## Example
``` swift
import CSVReader

let file = URL(fileURLWithPath: "path/to/file")
let reader = CSVReader()

do {
  let contents = try reader.read(file: file)
  
  let headers = contents.headers // The first line is pulled out as headers unless specified otherwise.
  let values = content.values // Values are an array of rows which are [String].
  
  let thisValue = content.value(ofColumnWithHeader: "Some Header", atIndex: 4) // Get a specfic value for a header on a line.
  
} catch {
  print("Something has gone wrong.")
}
```
