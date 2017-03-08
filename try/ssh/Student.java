package ssh;

import java.util.HashSet;
import java.util.Set;

public class Student {
	private Long id;
	private String name;
	
	private Set<String> coo = new HashSet<String>();
	
	public Set<String> getCoo() {
		return coo;
	}
	public void setCoo(Set<String> coo) {
		this.coo = coo;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
