package mall.cart;

public class CartDataBean {
	private int cart_id; // 카트 아이디
	private String buyer; // 구매자(회원 아이디)
	private int product_id; // 상품 아이디
	private String product_title; // 상품 제목
	private int product_size; // 상품 사이즈
	private int buy_price; // 판매가(할인율 적용)
	private int buy_count; // 구매 수량
	private String product_image; // 상품 이미지

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
