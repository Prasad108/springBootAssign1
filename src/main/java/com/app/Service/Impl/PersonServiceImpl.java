package com.app.Service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.DAO.PersonDAO;
import com.app.Service.PersonService;
import com.app.pojo.Person;


@Service("personService")
public class PersonServiceImpl implements PersonService {

	@Autowired
	PersonDAO personDAO;
	
	@Override
	public void create(Person person) {
		personDAO.create(person);

	}

	@Override
	public void update(Person person) {
		personDAO.update(person);

	}

	@Override
	public Person edit(int id) {
		
		return personDAO.edit(id);
	}

	@Override
	public void delet(Person person) {
		personDAO.delet(person);

	}

	@Override
	public Person find(int id) {
		
		return personDAO.find(id);
	}

	@Override
	public List<Person> getall() {
		
		return personDAO.getall();
	}

}
