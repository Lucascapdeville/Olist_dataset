This analyses focus on a 2 prone approach to the OLIST dataset.

The first one is quite simple WHERE are the buyers and Where are the sellers in this data.  

We can see the table bellow that SP(São Paulo) is ahead in this topic with a massive lead in sellers
![Vendendores_compradores2](https://user-images.githubusercontent.com/108835745/187463509-35c4e78a-5c07-4a7b-bee9-1975f97f764e.png)

But with this first look we start to see a tendency in the data.
As the avg price  starts to grow the number of sellers,buyers and spend starts to fall.

At first look we migth not see the corelation between these 2 facts, but in this dataset we have the freight cost

![Frete_sp](https://user-images.githubusercontent.com/108835745/187466759-cbc7fea4-0bb2-490f-a301-834570ee0441.png)

And with the freight cost it becames clear the brutal diference state by state.

SP being the region with the biggest number of sellers there is a almost 500% gap between the avarage cost of freight.

That by itself should be a flag to start a better planing in logistic to decrese the cost of freight and increse the viability of buyers growth in those regions

To better understand how much the price of freight affects the buyers decision we can see in the data bellow the number of orders by percentage of price.

![Pedidos_pct](https://user-images.githubusercontent.com/108835745/187481920-af069b9c-a002-47e6-849f-19f8986de59a.png)

In conclusion, In this dataset we can see a correlation between number of orders and freight pct cost where the 10-19% is in the gold zone for pricing.
