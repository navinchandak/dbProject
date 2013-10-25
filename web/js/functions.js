
$(document).ready(function(){

    var current = "#match-button";//already set as active in the code below


//    var welcomeText = $("#batting-content").html();
  //  $("#main-content").html(welcomeText);
	 $(".accordion-group").hide();
    $(".match-content").show();
    $(".common-content").show();

    // $("#enter-site-button").click(function(){
    //  $("#enter-site-content").fadeOut(function(){
    //      var welcomeText = $("#welcome-content").html();
    //      $("#main-content").html(welcomeText);
    //      $("#header-content").fadeIn();
    //      $("#main-content").fadeIn();
    //  });
    // });
    $("#batting-button").click(function(){
        //if (current != "welcome") {
		 		$("#queryType").
			  $(current).parent().removeClass("active");
			  $("#batting-button").parent().addClass("active");
			  current="#batting-button";
			   
            $(".accordion-group").hide(function(){
                //$(".batting-content").fadeIn();
            });

				$(".batting-content").show(function(){});
				$(".common-content").show(function(){});

        //}
    });
    $("#match-button").click(function(){
        //if (current != "welcome") {
			  $(current).parent().removeClass("active");
			  $("#match-button").parent().addClass("active");
			  current="#match-button";
            $(".accordion-group").hide(function(){
                //$(".match-content").fadeIn();
            });
				$(".match-content").show(function(){});
				$(".common-content").show(function(){});
        //}
    });
    $("#bowling-button").click(function(){
			  $(current).parent().removeClass("active");
			  $("#bowling-button").parent().addClass("active");
			  current="#bowling-button";
        //if (current != "welcome") {
            $(".accordion-group").hide(function(){
                //$(".match-content").fadeIn();
            });
				$(".bowling-content").show(function(){});
				$(".common-content").show(function(){});
        //}
    });
	 
    /*$("#about-button").click(function(){
        if (current != "about") {
            $("#main-content").fadeOut(function(){
                var aboutText = $("#about-content").html();
                current = "about"
                $("#main-content").html(aboutText);
                $("#main-content").fadeIn();
            });
        }
    });
    $("#projects-button").click(function(){
        if (current != "projects") {
            $("#main-content").fadeOut(function(){
                var projectsText = $("#projects-content").html();
                current = "projects"
                $("#main-content").html(projectsText);
                $("#main-content").fadeIn();
            });
        }
    });
    $("#contact-button").click(function(){
        if (current != "contact") {
            $("#main-content").fadeOut(function(){
                var contactText = $("#contact-content").html();
                current = "contact"
                $("#main-content").html(contactText);
                $("#main-content").fadeIn();
            });
        }
    });
    $("#resume-button").click(function(){
        if (current != "resume") {
            $("#main-content").fadeOut(function(){
                var resumeText = $("#resume-content").html();
                current = "resume"
                $("#main-content").html(resumeText);
                $("#main-content").fadeIn();
            });
        }
    });*/
});
	 function temp(str){
		 if(!(typeof str === "string")) return false;
		 if(str.substr(0,6)==="player"){
			 return +str.substr(6,str.length-6);
		 }
		 else{
			 return false;
		 }
	 }
    function addPlayer(){
        //alert("haha");
		  //alert(temp("player2")==false);
        
        form=document.getElementById("Players");
        formChild=form.childNodes;
        for(var i=formChild.length-1;i>=0;i--){
            //alert(formChild[i]+" "+formChild[i].name+" " + temp(formChild[i].name));
            
            if(temp(formChild[i].name)!=false && temp(formChild[i+1].name)==false){
					var txtNode = document.createTextNode(" or");	
               var abcd=formChild[i].cloneNode(true);
					var brk=document.createElement("br");
                abcd.name="player"+((temp(formChild[i].name))+1);
					 abcd.placeholder=abcd.name;
					 abcd.id=abcd.name;
					 //abcd.className=formChild[i].className;
                form.insertBefore(abcd,formChild[i+1]);
                form.insertBefore(txtNode,abcd);
					 form.insertBefore(brk,abcd);
					 //alert(formChild[i+1].nodeValue);
                break;
            }
        }
        return true;
    }
