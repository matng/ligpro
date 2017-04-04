package com.hxd.vo;

import java.util.ArrayList;
import java.util.List;

import org.codehaus.jackson.annotate.JsonProperty;

public class AdditionalParameters {

	private List<Item> children = new ArrayList<Item>();
	
	private String id;
	
	@JsonProperty("item-selected")
	private boolean itemSelected;

	public List<Item> getChildren() {
		return children;
	}

	public void setChildren(List<Item> children) {
		this.children = children;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public boolean isItemSelected() {
		return itemSelected;
	}

	public void setItemSelected(boolean itemSelected) {
		this.itemSelected = itemSelected;
	}
	
	
	
	
}
