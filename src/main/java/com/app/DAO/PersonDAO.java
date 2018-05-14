package com.app.DAO;

import java.util.List;



import com.app.pojo.Person;


public interface PersonDAO {
	public void create(Person person);
	public void update(Person person);
	public Person edit(int id);
	public void delet(Person person);
	public Person find(int id);
	public List<Person> getall();

}
