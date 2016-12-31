package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ApplicationDAO {
	
	private boolean isExecuted; 
	public Connection getConnection(){
		String connectionUrl = "jdbc:mysql://classvm68.cs.rutgers.edu:3306/myDatabase?autoReconnect=true";
		Connection connection = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			connection = DriverManager.getConnection(connectionUrl,"root", "RepThorShp2");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return connection;
		
	}
	
	public void closeConnection(Connection connection){
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public boolean checkLogin(String username, String password){
		
		boolean isValidLogin = true;
		try{
			String selectString = "SELECT UserID FROM Users WHERE Username = '" + username + 
					"' and Password = '" + password + "';";
			Connection dbConnection = getConnection();
			PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
			ResultSet result = preparedStatement.executeQuery();
			if (!result.next() ) {
				System.out.println("user not found");
			    isValidLogin = false;
			}
		}catch(SQLException e){
			isValidLogin = false;
		}
		System.out.println("user found");
		return isValidLogin;
	}
	
	public void editUser(String oldUsername, String newUsername, String newPassword){
		
		try {
			String u = null;
			if (newUsername.length() == 0){
				u = "UPDATE Users SET Password = '" + newPassword + "' WHERE Username = '"  + oldUsername +  "';";
			} else if (newPassword.length() == 0){
				u = "UPDATE Users SET Username = '" + newUsername + "' WHERE Username = '"  + oldUsername +  "';";
			}else {
				u = "UPDATE Users SET Username = '" + newUsername + "', Password = '" + newPassword + "' WHERE Username = '"  + oldUsername +  "';";
			}
			Connection dbConnection = getConnection();
			PreparedStatement p = dbConnection.prepareStatement(u);
			p.executeUpdate();
		} catch (SQLException e){
			System.out.println("credentials already exist");
		}
	}
	
	public boolean checkRegistration(String email, String username, String password){
		
		boolean isValidRegistration = true;
		if (email.length() == 0 || username.length() == 0 || password.length() == 0){
			isValidRegistration = false;
		}
		else{
			try{
				String selectString = "insert into Users (Email,Username,Password) values ('" + email + 
						"','" + username + "','" + password + "');";
				Connection dbConnection = getConnection();
				PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
				int rowsUpdated = preparedStatement.executeUpdate();
				if (rowsUpdated != 1){
					isValidRegistration = false;
				}
			}catch(SQLException e){
				isValidRegistration = false;
			}
		}
			
		return isValidRegistration;
	}
	
	public void deleteAccount(String username) {
		try {
			String deleteString = "delete FROM Users WHERE Username = '" + username + "';";
			Connection dbConnection = getConnection();
			PreparedStatement preparedStatement = dbConnection.prepareStatement(deleteString);
			int rowsUpdated = preparedStatement.executeUpdate();
			if (rowsUpdated != 1) {
				System.out.println("Deletion Failed");
			}
		} catch (SQLException e){
			System.out.println("SQL Exeption");
		}
	}
	
	public void deleteAuction(String vehicleID){
		try {
			String deleteString = "delete FROM Vehicles WHERE VehicleID = '" + vehicleID + "';";
			Connection dbConnection = getConnection();
			PreparedStatement preparedStatement = dbConnection.prepareStatement(deleteString);
			int rowsUpdated = preparedStatement.executeUpdate();
			if (rowsUpdated != 1) {
				System.out.println("Deletion Failed");
			}
		} catch (SQLException e){
			e.printStackTrace();
			System.out.println("SQL Exeption");
		}
	}
	
	public void deleteBid(String bidID){
		try {
			//new max bid
			Connection dbConnection = getConnection();
			String s = "SELECT MAX(Amount) " + 
					"FROM Bids, Vehicles " +
					"WHERE VehicleID = PlacedOn AND BidID = " + bidID + " AND Amount <> CurrentBid;";
			
			PreparedStatement p = dbConnection.prepareStatement(s);
			ResultSet r = p.executeQuery();
			String newMax = "0";
			if (r.next()){
				newMax = r.getString(1);
			}
			
			
			String deleteString = "delete FROM Bids WHERE BidID = '" + bidID + "';";
			PreparedStatement preparedStatement = dbConnection.prepareStatement(deleteString);
			int rowsUpdated = preparedStatement.executeUpdate();
			if (rowsUpdated != 1) {
				System.out.println("Deletion Failed");
			}
			
			//update CurrentBid
			String i = "UPDATE Vehicles SET CurrentBid = " + newMax + " WHERE VehicleID = (SELECT PlacedOn FROM Bids WHERE BidID = " + bidID + ");";
			p = dbConnection.prepareStatement(i);
			
			rowsUpdated = p.executeUpdate();
			if (rowsUpdated != 1) {
				System.out.println("Current Bid update failed");
			}
		} catch (SQLException e){
			e.printStackTrace();
			System.out.println("SQL Exeption");
		}
	}
	
	public boolean isValidBid(String username, String vehicleID, String amount, String maxAmount){
		try{
			if (Float.parseFloat(amount) > Float.parseFloat(maxAmount)){
				
				Connection dbConnection = getConnection();
				String selectString = "SELECT UserID FROM Users WHERE Username = '" + username + "';";
				PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
				ResultSet result = preparedStatement.executeQuery();
				result.next();
				String userID = result.getString(1);
				
				String insertString = "INSERT INTO Bids (PlacedOn, PlacedBy, Amount) values ('" + vehicleID + 
						"','" + userID + "','" + amount + "');";
				PreparedStatement preparedStatement2 = dbConnection.prepareStatement(insertString);
				preparedStatement2.executeUpdate();
				System.out.println("Bid succeeded");
				
				insertString = "UPDATE Vehicles SET CurrentBid = " + amount + " WHERE VehicleID = " + vehicleID + ";";
				preparedStatement = dbConnection.prepareStatement(insertString);
				preparedStatement.executeUpdate();
						
				/*Get new BidID*/
				String selectString2 = "SELECT BidID FROM Bids ORDER BY PostTime DESC LIMIT 1;";
				PreparedStatement preparedStatement3 = dbConnection.prepareStatement(selectString2);
				ResultSet result2 = preparedStatement3.executeQuery();
				result2.next();
				String BidID = result2.getString(1);	
				System.out.println("BidID retrieved");
				
				/*Send emails to all involved in Bid besides the current Bidder*/
				String selectString3 = "SELECT DISTINCT UserID FROM Bids, Users WHERE PlacedBy = UserID AND UserID <> '" + userID + "';";
				PreparedStatement preparedStatement4 = dbConnection.prepareStatement(selectString3);
				ResultSet result3 = preparedStatement4.executeQuery();
				System.out.println("Related users identified");
				
				/*Get name of auction*/
				String selectString4 = "SELECT PostTitle FROM Vehicles WHERE VehicleID = '" + vehicleID + "';";
				PreparedStatement preparedStatement5 = dbConnection.prepareStatement(selectString4);
				ResultSet result4 = preparedStatement5.executeQuery(); 
				result4.next();
				String postTitle = result4.getString(1).toUpperCase();
				System.out.println("Auction title found");
				
				while (result3.next()){
					String insertString2 = "INSERT INTO Email (Sender, Receiver, Subject, Content) VALUES ('" + "4" + "','" + result3.getString(1) + "','" + "Higher Bid Alert" + "','" + "Your bid on " + postTitle + "has been beaten" + "');";
					PreparedStatement p = dbConnection.prepareStatement(insertString2);
					p.executeUpdate();
					System.out.println("Email inserted");
				}
				return true;
			}
			else {
				System.out.println("Bid too low");
				return false;
			}
			
		}catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public void updateAuctions() {
		
		try{
			/*Find all auctions that have closed that aren't assigned a winner*/
			Connection dbConnection = getConnection();
			String selectString = "SELECT DISTINCT VehicleID FROM Vehicles WHERE CloseTime < NOW() AND Winner IS NULL OR Winner = '';";
			PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
			ResultSet auctions = preparedStatement.executeQuery();
			
			while (auctions.next()){
				String vehicleID = auctions.getString(1);
				
				/*Find userID of winner of auction*/
				selectString = "SELECT DISTINCT UserID " +
						"FROM Bids, Vehicles, Users " +
						"WHERE VehicleID = " + vehicleID + " AND VehicleID = PlacedOn AND PlacedBy = UserID ORDER BY Amount DESC LIMIT 1;";
				preparedStatement = dbConnection.prepareStatement(selectString);
				ResultSet userID = preparedStatement.executeQuery();
				System.out.println("UserID found");
				
				/*Get VehicleID and Title of auction*/
				selectString = "SELECT PostTitle, VehicleID FROM Vehicles WHERE VehicleID = '" + vehicleID + "';";
				preparedStatement = dbConnection.prepareStatement(selectString);
				ResultSet title = preparedStatement.executeQuery(); 
				title.next();
				String postTitle = title.getString(1).toUpperCase();
				System.out.println("Vehicle found");
				
				String uID = null;
				if (userID.next()){
					uID = userID.getString(1);
					/*Send email to winner*/
					String insertString = "INSERT INTO Email (Sender, Receiver, Subject, Content) VALUES ('" + "4" + "','" + uID + "','" + "You won bid!" + "','" + "Congratulations, you won the auction on " + postTitle + "')";
					preparedStatement = dbConnection.prepareStatement(insertString);
					preparedStatement.executeUpdate();
					System.out.println("Email sent");
					
					/*set winner of vehicle*/
					insertString = "UPDATE Vehicles SET Winner = " + uID + " WHERE VehicleID = " + vehicleID + ";";
					preparedStatement = dbConnection.prepareStatement(insertString);
					preparedStatement.executeUpdate();
				}
				
				
			}
		} catch (SQLException e){
			e.printStackTrace();
		}
		
	}
	
	public boolean InsertCars(String userid, String bidtitle, String closetime,String color, 
			String horsepower,String mileage, String mpg,String manufacturer,String model, String year,String door,String seat, String img){
		
		boolean InsertCars = true;
			try{
				String selectString = "insert into Vehicles(Type,Postedby,PostTitle,"
						+ "CloseTime,Color,Horsepower,Mileage,Mpg,Manufacturer,Model,Year, CurrentBid, Img)"+
						" values ('" + "car" + "'," + userid + ",'" + bidtitle + "','" + closetime + "','" + color + "'," + "" + horsepower + "," + mileage + "," + mpg + ",'" + manufacturer + "','" + model + "'," + year + "," + 0 + ",'" + img + "');";
				Connection dbConnection = getConnection();
				PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
				int rowsUpdated = preparedStatement.executeUpdate();
				if (rowsUpdated != 1){
					InsertCars = false;
				}
			}catch(SQLException e){
				e.printStackTrace();
				InsertCars = false;
			}
			try{
			String selectString = "SELECT VehicleID FROM Vehicles ORDER BY PostedTime DESC LIMIT 1;";
			Connection dbConnection = getConnection();
			PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
			ResultSet result = preparedStatement.executeQuery();
			result.next();
			String vehicleID = result.getString(1);
			String selectString2 = "insert into Cars(CarID, Doors,Seats) values (" + vehicleID + "," + door + "," + seat + ");";
			dbConnection = getConnection();
			preparedStatement = dbConnection.prepareStatement(selectString2);
			int rowsUpdated = preparedStatement.executeUpdate();
			if (rowsUpdated != 1){
				InsertCars = false;
			}
			}catch(SQLException e){
				e.printStackTrace();
				InsertCars = false;
			}
		return InsertCars;
	}
	
	public boolean InsertTrucks(String userid, String bidtitle, String closetime,String color,String horsepower,String mileage, String mpg,
			String manufacturer,String model, String year,String door,String seat,String height,String towcapacity,String clearance, String img){
		
		boolean InsertTrucks = true;
			try{
				String selectString = "insert into Vehicles(Type,Postedby,PostTitle,"
						+ "CloseTime,Color,Horsepower,Mileage,Mpg,Manufacturer,Model,Year, CurrentBid, Img)"+
						" values ('" + "trk" + "'," + userid + ",'" + bidtitle + "','" + closetime + "','" + color + "'," + horsepower + "," + mileage + "," + mpg + ",'" + manufacturer + "','" + model + "'," + year + "," + 0 + ",'" + img + "');";
				Connection dbConnection = getConnection();
				PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
				int rowsUpdated = preparedStatement.executeUpdate();
				if (rowsUpdated != 1){
					InsertTrucks = false;
				}
			}catch(SQLException e){
				e.printStackTrace();
				InsertTrucks = false;
			}
			try{
			String selectString = "SELECT VehicleID FROM Vehicles ORDER BY PostedTime DESC LIMIT 1;";
			Connection dbConnection = getConnection();
			PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
			ResultSet result = preparedStatement.executeQuery();
			result.next();
			String vehicleID = result.getString(1);
			String selectString2 = "insert into Trucks(TruckID, Doors,Seats,Height,TowCapacity, Clearance) values (" + vehicleID + "," + door + "," + seat + "," + height + "," + towcapacity + "," + clearance + ");";
			dbConnection = getConnection();
			preparedStatement = dbConnection.prepareStatement(selectString2);
			int rowsUpdated = preparedStatement.executeUpdate();
			if (rowsUpdated != 1){
				InsertTrucks = false;
			}
			}catch(SQLException e){
				e.printStackTrace();
				InsertTrucks = false;
			}
		return InsertTrucks;
	}
	
	public boolean InsertMotorcycles(String userid, String bidtitle, String closetime,String color, 
			String horsepower,String mileage, String mpg,String manufacturer,String model, String year,String handlebartype,String seattype, String img){
		
		boolean InsertMotorcycles = true;
			try{
				String selectString = "insert into Vehicles(Type,Postedby,PostTitle,"
						+ "CloseTime,Color,Horsepower,Mileage,Mpg,Manufacturer,Model,Year, CurrentBid, Img)"+
						" values ('" + "mtr" + "'," + userid + ",'" + bidtitle + "','" + closetime + "','" + color + "'," + horsepower + "," + mileage + "," + mpg + ",'" + manufacturer + "','" + model + "'," + year + "," + 0 + ",'" + img + "');";
				Connection dbConnection = getConnection();
				PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
				int rowsUpdated = preparedStatement.executeUpdate();
				if (rowsUpdated != 1){
					InsertMotorcycles = false;
				}
			}catch(SQLException e){
				e.printStackTrace();
				InsertMotorcycles = false;
			}
			try{
				String selectString = "SELECT VehicleID FROM Vehicles ORDER BY PostedTime DESC LIMIT 1;";
				Connection dbConnection = getConnection();
				PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
				ResultSet result = preparedStatement.executeQuery();
				result.next();
				String vehicleID = result.getString(1);
				String selectString2 = "insert into Motorcycles(MotorcycleID, HandlebarType,SeatType) values (" + vehicleID + ",'" + handlebartype + "','" + seattype + "');";
				dbConnection = getConnection();
				preparedStatement = dbConnection.prepareStatement(selectString2);
				int rowsUpdated = preparedStatement.executeUpdate();
				if (rowsUpdated != 1){
					InsertMotorcycles = false;
				}
				}catch(SQLException e){
					e.printStackTrace();
					InsertMotorcycles = false;
				}
		return InsertMotorcycles;
	}
	
	public boolean CRdeletion(String username){
			
			boolean Crr = true;
	
				try{
					String selectString = "delete from CustomerRep where Username "+" = "+"('" + username + "');";
					Connection dbConnection = getConnection();
					PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
					int rowsUpdated = preparedStatement.executeUpdate();
					if (rowsUpdated != 1){
						Crr = false;
					}
				}catch(SQLException e){
					e.printStackTrace();
					Crr = false;
				}
				
			return Crr;
	}
	
	public boolean Crr(String email, String username, String password,String name){
			
			boolean Crr = true;
			if (email.length() == 0 || username.length() == 0 || password.length() == 0|| name.length() == 0){
				Crr = false;
			}
			else{
				try{
					String selectString = "insert into CustomerRep (Username,Password,name,Email) values ('" + username + 
							"','" + password + "','" + name + "','" + email + "');";
					Connection dbConnection = getConnection();
					PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
					int rowsUpdated = preparedStatement.executeUpdate();
					if (rowsUpdated != 1){
						Crr = false;
					}
				}catch(SQLException e){
					Crr = false;
				}
			}
				
			return Crr;
		}
	
	public boolean checkCRLogin(String username, String password){
		
		boolean isValidLogin = true;
		try{
			String selectString = "SELECT RepID FROM CustomerRep WHERE Username = '" + username + 
					"' and Password = '" + password + "';";
			Connection dbConnection = getConnection();
			PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
			ResultSet result = preparedStatement.executeQuery();
			if (!result.next() ) {
				System.out.println("rep not found");
			    isValidLogin = false;
			}
		}catch(SQLException e){
			e.printStackTrace();
			isValidLogin = false;
		}
		System.out.println("rep found");
		return isValidLogin;
		
	}
	
	public void messageCR(String message, String repUsername, String username, String subject, String type){
		
		try {
			Connection dbConnection = getConnection();
			
			
			String selectString = "SELECT UserID FROM Users WHERE Username = '" + username + "';"; 
			PreparedStatement p = dbConnection.prepareStatement(selectString);
			ResultSet result = p.executeQuery();
			result.next();
			String userID = result.getString(1);
			String repID = null;
			if (repUsername.length() == 0){
				selectString = "SELECT RepID FROM CustomerRep ORDER BY RAND() LIMIT 1;"; 
				p = dbConnection.prepareStatement(selectString);
				result = p.executeQuery();
				result.next();
				repID = result.getString(1);
			}
			else {
				selectString = "SELECT RepID FROM CustomerRep WHERE Username = '" + repUsername + "';"; 
				p = dbConnection.prepareStatement(selectString);
				result = p.executeQuery();
				result.next();
				repID = result.getString(1);
			}
			String insertString = "INSERT INTO Email (Sender, Receiver, Subject, Content, Type) VALUES (" + userID + "," + repID + ",'" + subject + "','" + message + "','" + type + "');";
			p = dbConnection.prepareStatement(insertString);
			p.executeUpdate();
		} catch (SQLException e){
			e.printStackTrace();
		}	
	}
	
	
	public void messageUser(String message, String repUsername, String username, String subject, String type){
		try {
			Connection dbConnection = getConnection();
			
			
			String selectString = "SELECT UserID FROM Users WHERE Username = '" + username + "';"; 
			PreparedStatement p = dbConnection.prepareStatement(selectString);
			ResultSet result = p.executeQuery();
			result.next();
			String userID = result.getString(1);
			String repID = null;
		
			selectString = "SELECT RepID FROM CustomerRep WHERE Username = '" + repUsername + "';"; 
			p = dbConnection.prepareStatement(selectString);
			result = p.executeQuery();
			result.next();
			repID = result.getString(1);
			
			String insertString = "INSERT INTO Email (Sender, Receiver, Subject, Content, Type) VALUES (" + repID + "," + userID + ",'" + subject + "','" + message + "','" + type + "');";
			p = dbConnection.prepareStatement(insertString);
			p.executeUpdate();
		} catch (SQLException e){
			e.printStackTrace();
		}	
	}
	
	
	public static void main(String[] args) {
		ApplicationDAO dao = new ApplicationDAO();
		Connection connection = dao.getConnection();
		
		System.out.println(connection);
	}
}
