package mall.cart;

public class CartDataBean {
	private int cart_id; // cart ID
	private String buyer; // buyer(user ID)
	private int product_id; // product ID
	private String product_title; // product name(title)
	private int product_size; // product size
	private int buy_price; // price
	private int buy_count; // count
	private String product_image; // product image

	public int getCart_id() {
		return cart_id;
	}

	public String getBuyer() {
		return buyer;
	}

	public int getProduct_id() {
		return product_id;
	}

	public String getProduct_title() {
		return product_title;
	}

	public int getProduct_size() {
		return product_size;
	}

	public int getBuy_price() {
		return buy_price;
	}

	public int getBuy_count() {
		return buy_count;
	}

	public String getProduct_image() {
		return product_image;
	}

	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}

	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public void setProduct_title(String product_title) {
		this.product_title = product_title;
	}

	public void setProduct_size(int product_size) {
		this.product_size = product_size;
	}

	public void setBuy_price(int buy_price) {
		this.buy_price = buy_price;
	}

	public void setBuy_count(int buy_count) {
		this.buy_count = buy_count;
	}

	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}

}
