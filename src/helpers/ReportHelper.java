package helpers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import utilities.DatabaseAccess;

public final class ReportHelper {
	
	public static String getCurrentDate() {
		
		String timeStamp = new SimpleDateFormat("MM / dd / yyyy").format(Calendar.getInstance().getTime());
		return timeStamp;
	}
	public static ArrayList<Integer> insertCriteria(String[] criteria){
		ArrayList<Integer> criteriaIds = new ArrayList<>();
		try {
			Connection connect = DatabaseAccess.connectDataBase();
			
			for(String names: criteria) {
				String queryString = "INSERT INTO criteria (criteria_name) VALUES(?)";
				
				PreparedStatement stmt = connect.prepareStatement(queryString,Statement.RETURN_GENERATED_KEYS);
				stmt.setString(1, names);
				stmt.execute();
				ResultSet res = stmt.getGeneratedKeys();
				if(res.next()) {
					criteriaIds.add( res.getInt(1));
				}
				res.close();
			}
			connect.close();
		}catch(Exception e) {
			//System.out.println("exception in insert section" + e);
		}
		return criteriaIds;					
	}
	
	public static Integer insertSection(String name) {
		Integer id = null;
		try {
			Connection connect = DatabaseAccess.connectDataBase();
	
				String queryString = "INSERT INTO section (section_name) VALUES(?)";

				PreparedStatement stmt = connect.prepareStatement(queryString,Statement.RETURN_GENERATED_KEYS);
				stmt.setString(1, name);
				stmt.execute();
				ResultSet res = stmt.getGeneratedKeys();
				
				if(res.next()) {
					id = res.getInt(1);
				}
				
				res.close();
				connect.close();
				
			} catch(Exception e) {
				//System.out.println("exception in insert section" + e);
			}
		return id;
	}
	
	public static void insertSectionCriteria(ArrayList<Integer> criteria, Integer section) {
		try {
			Connection connect = DatabaseAccess.connectDataBase();
				for(Integer criteriaId : criteria) {
					String queryString = "INSERT INTO criteria_section (criteria_id,section_id) VALUES(?,?)";
	
					PreparedStatement stmt = connect.prepareStatement(queryString);
					stmt.setInt(1, criteriaId);
					stmt.setInt(2, section);
					stmt.execute();
					
				}
				connect.close();
				
			} catch(Exception e) {
				//System.out.println("exception in insert criteriaSec" + e);
			}
	}
	
	public static void insertTemplate(Integer sectionOne, Integer sectionTwo, Integer sectionThree, String tempName, 
										String date, Integer department_id) {
		
		try {
			Connection connect = DatabaseAccess.connectDataBase();
				
			String queryString = "INSERT INTO template (department_id, date, template_name, section_1, section_2, section_3) "
					+ "VALUES(?,NOW(),?,?,?,?)";

			PreparedStatement stmt = connect.prepareStatement(queryString);
			stmt.setInt(1, department_id);
			stmt.setString(2, tempName);
			stmt.setInt(3, sectionOne);
			stmt.setInt(4, sectionTwo);
			stmt.setInt(5, sectionThree);
			stmt.execute();
				
			connect.close();
				
		} catch(Exception e) {
			//System.out.println("exception in insert insertTemplate" + e);
		}
		
	}
	
	public static ArrayList<String> getTemplateDepartments(Integer templateID){
		ArrayList<String> departments = new ArrayList<>();
		try {
			Connection connect = DatabaseAccess.connectDataBase();
				
			String queryString = "SELECT name FROM department"
								+ " INNER JOIN template"
								+ " ON template.department_id = department.department_id"
								+ " WHERE template.template_id = ?";

			PreparedStatement stmt = connect.prepareStatement(queryString);
			stmt.setInt(1,templateID);
			ResultSet departmentNames = stmt.executeQuery();
			if(departmentNames.next()) {
				departments.add(departmentNames.getString(1));
				//System.out.println(departmentNames.getString(1));
			}
			departmentNames.close();
			connect.close();
				
		} catch(Exception e) {
			//System.out.println("exception in insert insertTemplate" + e);
			return null;
		}
		return departments;
	}
	
	public static ArrayList<String> getDepartmentEmployees(Integer tempID){
		ArrayList<String> employees = new ArrayList<String>();
		
		try {
			Connection connect = DatabaseAccess.connectDataBase();
			
			String queryString = "SELECT firstname,lastname FROM employee"								
								+ " INNER JOIN template"
								+ " ON template.department_id = employee.department_id"
								+ " WHERE template.template_id = ? ";
			PreparedStatement stmt = connect.prepareStatement(queryString);
			stmt.setInt(1,tempID);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				System.out.println("RS feed: "+rs.getString(2) + ", " + rs.getString(1));
				employees.add(rs.getString(2) + ", " + rs.getString(1));
			}
			rs.close();
			connect.close();
		}catch(Exception e) {
			System.out.println("Error in getDepartmentEmployees: " + e);
			return null;
		}
		return employees;
		
	}
	
	public static ArrayList<String> getDepartmentGroups(Integer tempID){
		ArrayList<String> group = new ArrayList<String>();
		
		try {
			Connection connect = DatabaseAccess.connectDataBase();
			
			String queryString = "SELECT name FROM groups"								
								+ " INNER JOIN template"
								+ " ON template.department_id = groups.department_id"
								+ " WHERE template.template_id = ? ";
			PreparedStatement stmt = connect.prepareStatement(queryString);
			stmt.setInt(1,tempID);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				//System.out.println("RS feed: "+rs.getString(2) + ", " + rs.getString(1));
				group.add(rs.getString(1));
			}
			rs.close();
			connect.close();
		}catch(Exception e) {
			System.out.println("Error in getDepartmentEmployees: " + e);
			return null;
		}
		return group;
		
	}
	
	public static ArrayList<String> getSectionNames(Integer templateID){
		ArrayList<String> sectionNames = new ArrayList<>();
		ArrayList<Integer> sectionIDs = new ArrayList<>();
		try {
			Connection connect = DatabaseAccess.connectDataBase();
				
			String queryString = "SELECT section_1, section_2, section_3 FROM template"								
								+ " WHERE template.template_id = ?";

			PreparedStatement stmt = connect.prepareStatement(queryString);
			stmt.setInt(1,templateID);
			ResultSet sectionID = stmt.executeQuery();
			if(sectionID.next()) {
				sectionIDs.add(sectionID.getInt(1));
				sectionIDs.add(sectionID.getInt(2));
				sectionIDs.add(sectionID.getInt(3));
			}
			sectionID.close();
			
			String secNames = "SELECT section_name FROM section WHERE section_id = ? ";
			for(Integer ID : sectionIDs) {
				PreparedStatement stmt2 = connect.prepareStatement(secNames);
				stmt2.setInt(1,ID);
				ResultSet sectionN = stmt2.executeQuery();
				if(sectionN.next()) {
					sectionNames.add(sectionN.getString(1));
					//System.out.println(sectionN.getString(1));
				}
				sectionN.close();
			}
			connect.close();
		} catch(Exception e) {
			//System.out.println("exception in insert getSectionNames" + e);
			return null;
		}
		return sectionNames;
	}
	
	public static Map<String,String> getCriteriaNames(Integer tempID, Integer tier){
		Map<String,String> cIDcName = new HashMap<String,String>();
		ArrayList<Integer> criteriaIDs = new ArrayList<>();
		ArrayList<String> criteriaNames = new ArrayList<>();
		try {
			Connection connect = DatabaseAccess.connectDataBase();
			Integer sectionID = getSectionID(tempID,tier);
			String queryString = "SELECT criteria_id FROM criteria_section"
								+ " WHERE section_id = ? ";
			
			PreparedStatement stmt = connect.prepareStatement(queryString);
			stmt.setInt(1,sectionID);
			ResultSet rsID = stmt.executeQuery();
			while(rsID.next()) {
				//System.out.println(rsID.getString(1));
				criteriaIDs.add(rsID.getInt(1));
			}
			rsID.close();
			
			String critNamesQuery = "SELECT criteria_name FROM criteria"
									+" WHERE criteria_id = ?";
			for(Integer critID : criteriaIDs) {
				PreparedStatement stmt2 = connect.prepareStatement(critNamesQuery);
				stmt2.setInt(1, critID);
				ResultSet critRsId = stmt2.executeQuery();
				while(critRsId.next()) {
					//System.out.println(critRsId.getString(1));
					criteriaNames.add(critRsId.getString(1));
				}
				critRsId.close();
			}
			connect.close();
			
		}catch(Exception e) {
			//System.out.println("exception in getCriteriaNames" + e);
			return null;
		} 
		Integer cnt = 0;
		for(String name : criteriaNames) {
			cIDcName.put(name, criteriaIDs.get(cnt).toString());
			cnt++;
		}
		return cIDcName;
	}
	
	private static Integer getSectionID(Integer tempID, Integer tier){
		Integer sectionID = 0;
		try {
			Connection connect = DatabaseAccess.connectDataBase();
			String queryString = "";
			if(tier == 1) {	
				queryString = "SELECT section_1 FROM template"								
								+ " WHERE template.template_id = ?";
			}
			if(tier == 2) {
				queryString = "SELECT section_2 FROM template"								
						+ " WHERE template.template_id = ?";
			}
			if(tier == 3) {
				queryString = "SELECT section_3 FROM template"								
						+ " WHERE template.template_id = ?";
			}
			PreparedStatement stmt = connect.prepareStatement(queryString);
			stmt.setInt(1,tempID);
			ResultSet rsID = stmt.executeQuery();
			if(rsID.next()) {
				sectionID=rsID.getInt(1);				
			}
			rsID.close();
			connect.close();
		} catch(Exception e) {
			//System.out.println("exception in getSectionID" + e);
			return null;
		}
		return sectionID;
		
		
	}
}

