SELECT * FROM Product LEFT JOIN OrderDetail on Product.ProductId = OrderDetail.ProductId WHERE OrderId IS NULL
ORDER BY Product.ProductId  