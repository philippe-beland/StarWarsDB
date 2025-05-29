# StarWarsDB

A comprehensive Star Wars database application that allows users to browse, search, and manage information about the Star Wars universe.

## Project Description

StarWarsDB is a personal project that serves as a digital encyclopedia and collection manager for Star Wars content. It combines a Swift-based frontend with Python backend scripts to create a powerful tool for cataloging and exploring the Star Wars universe in detail.

The application connects to a Supabase database to store and retrieve information about characters, planets, species, starships, and other entities from the franchise. It features web scraping functionality that automatically collects data from Wookieepedia to enrich the database with canonical information.

What makes this project unique is its ability to track relationships between different Star Wars elements and their appearances across various media sources (books, comics, films, TV shows), providing a comprehensive reference system for Star Wars enthusiasts.

## Overview

StarWarsDB is a Swift-based iOS/macOS application with a Python backend component for data collection. The app provides a user-friendly interface to explore and manage various Star Wars entities including characters, planets, species, starships, organizations, and more.

## Features

- **Comprehensive Data Model**: Includes detailed information about characters, planets, species, starships, droids, organizations, and other Star Wars entities
- **Supabase Integration**: Uses Supabase as a backend database service for data storage and retrieval
- **User Authentication**: Secure login system for user access
- **Search Functionality**: Easily find entities by name or other attributes
- **Data Management**: Add, edit, and organize Star Wars information
- **Source Tracking**: Link entities to their appearances in various Star Wars media
- **Wookieepedia Integration**: Python scraper to collect data from the Star Wars wiki

## Technical Architecture

### Swift App (iOS/macOS)

- **SwiftUI**: Modern declarative UI framework for building the interface
- **MVVM Architecture**: Clear separation of concerns with Models, Views, and ViewModels
- **Supabase Client**: API integration for database operations
- **Entity Relationships**: Comprehensive data model with relationships between different Star Wars entities

### Python Backend

- **Web Scraping**: Tools to collect data from Wookieepedia using BeautifulSoup
- **Data Processing**: Scripts to process and format the collected data
- **Database Integration**: Tools to upload data to Supabase

## Entity Types

- Characters
- Planets
- Species
- Starships
- Starship Models
- Droids
- Organizations
- Creatures
- Series
- Arcs
- Sources (books, comics, films, etc.)
- Artists/Authors
- Varia (miscellaneous items)

## Getting Started

### Prerequisites

- Xcode 15+ for iOS/macOS development
- Python 3.8+ for backend scripts
- Supabase account for database services

### Setup

1. Clone the repository
2. Set up your Supabase credentials in the Swift app
3. Install Python dependencies with `pip install -r Python/requirements.txt`
4. Open the Xcode project and build the app

## Data Collection

The Python component includes scripts to:

1. Scrape data from Wookieepedia
2. Process and format the data
3. Upload images and information to the database

## Future Enhancements

- Timeline visualization of Star Wars events
- Advanced filtering and sorting options
- Offline mode for data access without internet connection

## License

This project is for personal use and educational purposes.

## Acknowledgments

- Star Wars and all related properties are owned by Lucasfilm Ltd. and The Walt Disney Company
- Wookieepedia for being an invaluable source of Star Wars information
