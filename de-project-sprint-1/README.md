# 1st sprint project
## RFM Segmentation Data mart for Food Delivery Application Users

### Description
RFM (from the English Recency, Frequency, Monetary Value) is a method of customer segmentation in which their loyalty is analyzed: how often, for what amounts and when last time this or that customer bought something. Based on this, client categories are selected to which marketing efforts should be directed.
Each customer is evaluated on three factors:
 - Recency - how long it's been since the last order.
 - Frequency - the number of orders.
 - Monetary Value - the amount of money spent by the customer.
  
<br>

### How to conduct RFM segmentation:

1) Assign three values to each customer - the Recency factor value, the Frequency factor value, and the Monetary Value factor value:
   - The Recency factor is measured by last order. Distribute customers on a scale of one to five, with a value of 1 being those who either haven't ordered at all or have been ordering for a very long time, and 5 being those who have ordered relatively recently.
   - The Frequency factor is measured by the number of orders. Distribute customers on a scale of one to five, where a value of 1 will be given to customers with the fewest orders and 5 to those with the most orders.
   - The Monetary Value factor is evaluated by the amount spent. Distribute the customers on a scale of one to five, where a value of 1 will be given to the customers with the smallest amount and 5 will be given to the customers with the largest amount.

2) Check that the number of customers in each segment is the same. For example, if there are only 100 customers in the database, then 20 customers should get a value of 1, another 20 should get a value of 2, etc...

### How to start the container
Run the command locally:

```
docker run -d --rm -p 3030:3030 -p 3000:3000 --name=de-project-sprint-1-server-local sindb/project-sprint-1:latest
```

Once the container is running, you will have access to:
1. VS Code
2. CloudBeaver
3. PostgreSQL (it is better to run queries through CloudBeaver)