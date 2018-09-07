import React, { Component } from 'react';
import Signup from './Signup';

const RegisterSection = ({showLogin}) => {
	let formMessage;
	if(showLogin)
		formMessage = "Login";
	else
		formMessage = "Sign Up";
	return(
		<section className="download bg-primary text-center" id="download">
      <div className="container">
        <div className="row">
          <div className="col-md-8 mx-auto">
            <h2 className="section-heading">{formMessage}</h2>
						
						<Signup login={showLogin}/>
						
           	<div className="badges">
              <a className="badge-link" href="#"><img src="" alt=""></img></a>
              <a className="badge-link" href="#"><img src="" alt=""></img></a>
            </div>
          </div>
        </div>
      </div>
    </section>
	)
}

export default RegisterSection;