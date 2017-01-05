package entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "four_images")

public class FourImages implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Long id;

	@Column(name = "wid")
	private Long wid;

	@Column(name = "url")
	private String url;

	@Column(name = "removed")
	private int removed;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getWid() {
		return wid;
	}

	public void setwid(Long wid) {
		this.wid = wid;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getRemoved() {
		return removed;
	}

	public void setRemoved(int removed) {
		this.removed = removed;
	}

}
