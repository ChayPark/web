package manager.product;


/*
-- 3. product table : information of product, most important table, consisted of 13 columns
-- product_id(product ID), product_brand(Brand of shoes), product_model(collection), product_name(name of product), product_price(price of product, $), 
-- product_count(number of products), product_size(product size), product_date(release date of product),
-- product_image(product image), product_detail1(product detail image1), product_detail2(product detail image2), product_detail3(product detail image3), product_description(product description)
*/
public class ProductDataBean {
	private int product_id;
	private String product_brand;
	private String product_model;
	private String product_title;
	private int product_price;
	private int product_count;
	private int product_size;
	private String product_date;
	private String product_image;
	private String product_detail1;
	private String product_detail2;
	private String product_detail3;
	private String product_description;
	
	public int getProduct_id() {
		return product_id;
	}
	
	public String getProduct_brand() {
		return product_brand;
	}
	
	public String getProduct_model() {
		return product_model;
	}
	
	public String getProduct_title() {
		return product_title;
	}
	
	public int getProduct_price() {
		return product_price;
	}
	
	public int getProduct_count() {
		return product_count;
	}
	
	public int getProduct_size() {
		return product_size;
	}
	
	public String getProduct_date() {
		return product_date;
	}
	
	public String getProduct_image() {
		return product_image;
	}
	
	public String getProduct_detail1() {
		return product_detail1;
	}
	
	public String getProduct_detail2() {
		return product_detail2;
	}
	
	public String getProduct_detail3() {
		return product_detail3;
	}
	
	public String getProduct_description() {
		return product_description;
	}
	
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	
	public void setProduct_brand(String product_brand) {
		this.product_brand = product_brand;
	}
	
	public void setProduct_model(String product_model) {
		this.product_model = product_model;
	}
	
	public void setProduct_title(String product_title) {
		this.product_title = product_title;
	}
	
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	
	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}
	
	public void setProduct_size(int product_size) {
		this.product_size = product_size;
	}
	
	public void setProduct_date(String product_date) {
		this.product_date = product_date;
	}
	
	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}
	
	public void setProduct_detail1(String product_detail1) {
		this.product_detail1 = product_detail1;
	}
	
	public void setProduct_detail2(String product_detail2) {
		this.product_detail2 = product_detail2;
	}
	
	public void setProduct_detail3(String product_detail3) {
		this.product_detail3 = product_detail3;
	}
	
	public void setProduct_description(String product_description) {
		this.product_description = product_description;
	}
	

	

}
