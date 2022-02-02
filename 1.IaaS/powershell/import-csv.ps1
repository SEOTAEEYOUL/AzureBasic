$products = Import-Csv .\test.csv -Encoding UTF8
$products | Format-Table

