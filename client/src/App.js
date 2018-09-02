import React, { Component } from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import Post from './components/Post';
import Signup from './components/Signup';
import NavBar from './components/Navbar';
import Header from './components/Header';
import RegisterSection from './components/RegisterSection';
import Features from './components/Features';
import ActionCall from './components/ActionCall';
import Social from './components/Social';
import Footer from './components/Footer';
import logo from './logo.svg';
import './App.css';
import './postCard.css';
import './signup.css';

class App extends Component {
	constructor(props){
		super(props)
		
		this.state = {
			posts: []
		}
	}
	
	componentDidMount(){
		fetch('http://localhost:3001/v1/posts', 
			{
				method: 'GET',
				headers: {
					'X-User-Email': 'tahbristol@gmail.com',
					'X-User-Token': 'Utgb-N7qYyxEDU2Dq25k'
				}
			})
		.then(data => data.json())
		.then(jsonData => {
			this.setState({
				posts: jsonData
			})
		})
	}
	
  render() {
    return (
      <Router>
				<div>
					<Route exact path="/signup" render={NavBar} />
					<Route exact path="/signup" render={Header} />
					<Route exact path="/signup" render={RegisterSection} />
					<Route exact path="/signup" render={(props) => <Features posts={this.state.posts} />} />
					<Route exact path="/signup" render={ActionCall} />
					<Route exact path="/signup" render={Social} />
					<Route exact path="/signup" render={Footer} />
				</div>
			</Router>
    );
  }
}

export default App;
