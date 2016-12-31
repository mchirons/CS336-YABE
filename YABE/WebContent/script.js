$(document).ready(function(){


		$('#cars-form').validate({
	    rules: {
	       bidtitle: {
	    	maxlength: 100,
	        required: true
	      },
		  
		  closetime: {
				required: true,
			},
		  
	      color: {
	        required: true,
	        maxlength: 20
	      },
		  
		   horsepower: {
	        required: true,
	        maxlength: 11
	      },
	      
	      horsepower: {
		        required: true,
		        maxlength: 11
		      },
		  mileage: {
			    required: true,
			    maxlength: 11
			  },
	      mpg: {
		        required: true,
		        maxlength: 11
		      },
	      manufacturer: {
		        required: true,
		        maxlength: 20
		      },
	      model: {
		        required: true,
		        maxlength: 30
		      },
		   
	      year: {
		        required: true,
		        maxlength: 4
		      },
	      door: {
		        required: true,
		        maxlength: 6
		      },
	      seats: {
		        required: true,
		        maxlength: 6
		      },
		  picture: {
			  required: true
		  },
		  
		  agree: "required"
		  
	    },
			highlight: function(element) {
				$(element).closest('.col-xs-10').removeClass('success').addClass('error');
			},
			success: function(element) {
				element
				.text('OK!').addClass('valid')
				.closest('.col-xs-10').removeClass('error').addClass('success');
			}
	  });
		
		$('#motorcycles-form').validate({
		    rules: {
		       bidtitle: {
		    	maxlength: 100,
		        required: true
		      },
			  
			  closetime: {
					required: true,
				},
			  
		      color: {
		        required: true,
		        maxlength: 20
		      },
			  
			   horsepower: {
		        required: true,
		        maxlength: 10
		      },
		      
		      horsepower: {
			        required: true,
			        maxlength: 10
			      },
			  mileage: {
				    required: true,
				    maxlength: 10
				  },
		      mpg: {
			        required: true,
			        maxlength: 10
			      },
		      manufacturer: {
			        required: true,
			        maxlength: 20
			      },
		      model: {
			        required: true,
			        maxlength: 30
			      },
			   
		      year: {
			        required: true,
			        maxlength: 4
			      },
		      door: {
			        required: true,
			        maxlength: 6
			      },
		      seats: {
			        required: true,
			        maxlength: 6
			      },
		      handlebartype: {
			        required: true,
			        maxlength: 25
			      },
		      seattype: {
			        required: true,
			        maxlength: 25
			      },
			      picture: {
					  required: true
				  },
			     
			  
			  agree: "required"
			  
		    },
				highlight: function(element) {
					$(element).closest('.col-xs-10').removeClass('success').addClass('error');
				},
				success: function(element) {
					element
					.text('OK!').addClass('valid')
					.closest('.col-xs-10').removeClass('error').addClass('success');
				}
		  });
		
		
		$('#trucks-form').validate({
		    rules: {
		       bidtitle: {
		    	maxlength: 100,
		        required: true
		      },
			  
			  closetime: {
					required: true,
			  },
			  
		      color: {
		        required: true,
		        maxlength: 20
		      },
			  
			   horsepower: {
		        required: true,
		        maxlength: 10
		      },
		      
		      horsepower: {
			        required: true,
			        maxlength: 10
			      },
			  mileage: {
				    required: true,
				    maxlength: 10
				  },
		      mpg: {
			        required: true,
			        maxlength: 10
			      },
		      manufacturer: {
			        required: true,
			        maxlength: 20
			      },
		      model: {
			        required: true,
			        maxlength: 30
			      },
			   
		      year: {
			        required: true,
			        maxlength: 4
			      },
		      door: {
			        required: true,
			        maxlength: 6
			      },
		      seats: {
			        required: true,
			        maxlength: 6
			      },
		      height: {
			        required: true,
			        maxlength: 10
			      },
		      towcapacity: {
			        required: true,
			        maxlength: 10
			      },
		      clearance: {
			        required: true,
			        maxlength: 10
			      },
			      
			      picture: {
					  required: true
				  },
			  
			  agree: "required"
			  
		    },
				highlight: function(element) {
					$(element).closest('.col-xs-10').removeClass('success').addClass('error');
				},
				success: function(element) {
					element
					.text('OK!').addClass('valid')
					.closest('.col-xs-10').removeClass('error').addClass('success');
				}
		  });
		
		

}); // end document.ready