$products = @(
  [pscustomobject]@{
    product_code = 'TEST00001'
    product_name = '볼펜'
    price = 100
  },
  [pscustomobject]@{
    product_code = 'TEST00002'
    product_name = '지우개'
    price = 50
  }
)

$products | Export-Csv -NoTypeInformation products.csv -Encoding UTF8

cat -Encoding UTF8 .\products.csv