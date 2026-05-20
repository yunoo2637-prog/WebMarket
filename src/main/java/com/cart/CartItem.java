package com.cart;

import java.io.Serializable; // 1. 직렬화 기능 불러오기 (대문자 S 주의!)

// 2. 클래스에 "이 객체는 직렬화(포장) 가능함!" 이라고 이름표(implements) 달아주기
public class CartItem implements Serializable {
	
	// (선택사항) 포장지 버전 번호. 안 적어도 되지만 적어두면 더 안전합니다.
	private static final long serialVersionUID = 1L; 

	private String productId;
	private int quantity;

	// 생성자
	public CartItem(String productId, int quantity) {
		this.productId = productId;
		this.quantity = quantity;
	}

	// 상품 ID
	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	// 수량
	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}