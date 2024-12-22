from urllib.request import urlopen
from bs4 import BeautifulSoup as soup


class WookieepediaScraping:
    """
    Class to scrap online
    """

    def __init__(self):
        """Init class"""

    def _scrape_web(self, entity_name):
        url = f"https://starwars.fandom.com/wiki/{entity_name.replace(' ', '_')}"
        url_data = urlopen(url)
        url_html = url_data.read()
        url_data.close()

        html = soup(url_html, "html.parser")
        infobox = html.find("aside", class_="portable-infobox")

        return infobox

    def scrape_character(self, entity_name: str):
        """Scrape character"""
        infobox = self._scrape_web(entity_name)
        image_url = infobox.find(
            "figure",
            class_="pi-item pi-image",
        )

        image_url = image_url.find("img")["src"] if image_url else None

        home_world = infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "homeworld"},
        )
        home_world = home_world.find("a").text if home_world else None

        species = infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "species"},
        )
        species = species.find("a").text if species else None

        sex = infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "gender"},
        )
        sex = sex.find("a").text if sex else None

        info_dict = {
            "image_url": image_url,
            "home_world": home_world,
            "species": species,
            "sex": sex,
        }
        return info_dict

    def scrape_creature(self, entity_name: str):
        """Scrape creature"""
        infobox = self._scrape_web(entity_name)
        image_url = infobox.find(
            "figure",
            class_="pi-item pi-image",
        )

        image_url = image_url.find("img")["src"] if image_url else None

        home_world = infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "planet"},
        )
        home_world = home_world.find("a").text if home_world else None

        designation = infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "designation"},
        )
        designation = designation.find("a").text if designation else None

        info_dict = {
            "image_url": image_url,
            "home_world": home_world,
            "designation": designation,
        }
        return info_dict

    def scrape_droid(self, entity_name: str):
        """Scrape droid"""
        infobox = self._scrape_web(entity_name)
        image_url = infobox.find(
            "figure",
            class_="pi-item pi-image",
        )

        image_url = image_url.find("img")["src"] if image_url else None

        class_type = infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "class"},
        )
        class_type = class_type.find("a").text if class_type else None

        info_dict = {
            "image_url": image_url,
            "class_type": class_type,
        }

        return info_dict

    def scrape_planet(self, entity_name: str):
        """
        Scrape planet
        """
        infobox = self._scrape_web(entity_name)
        image_url = infobox.find(
            "figure",
            class_="pi-item pi-image",
        )

        image_url = image_url.find("img")["src"] if image_url else None

        region = infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "region"},
        )
        region = region.find("a").text if region else None

        sector = infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "sector"},
        )
        sector = sector.find("a").text if sector else None

        system = infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "system"},
        )
        system = system.find("a").text if system else None

        capital_city = infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "capital"},
        )
        capital_city = capital_city.find("a").text if capital_city else None

        info_dict = {
            "image_url": image_url,
            "region": region,
            "sector": sector,
            "system": system,
            "capital_city": capital_city,
        }

        return info_dict

    def scrape_source(self, entity_name: str):
        """Scrape source"""
        infobox = self._scrape_web(entity_name)
        image_url = infobox.find(
            "figure",
            class_="pi-item pi-image",
        )

        image_url = image_url.find("img")["src"] if image_url else None

        timeline = infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "timeline"},
        )

        timeline = timeline.find("a").text if timeline else None

        info_dict = {
            "image_url": image_url,
            "timeline": timeline,
        }

        return info_dict

    def scrape_species(self, entity_name: str):
        """Scrape species"""
        infobox = self._scrape_web(entity_name)
        image_url = infobox.find(
            "figure",
            class_="pi-item pi-image",
        )

        image_url = image_url.find("img")["src"] if image_url else None

        homeworld = infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "planet"},
        )

        homeworld = homeworld.find("a").text if homeworld else None

        info_dict = {
            "image_url": image_url,
            "homeworld": homeworld,
        }

        return info_dict

    def scrape_starship_model(self, entity_name: str):
        """Scrape starship model"""
        infobox = self._scrape_web(entity_name)
        image_url = infobox.find(
            "figure",
            class_="pi-item pi-image",
        )

        image_url = image_url.find("img")["src"] if image_url else None

        class_type = infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "type"},
        )
        class_type = class_type.find("a").text if class_type else None

        line = infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "model"},
        )

        line = line.find("a").text if line else None

        info_dict = {
            "image_url": image_url,
            "class_type": class_type,
            "line": line,
        }

        return info_dict

    def scrape_starship(self, entity_name: str):
        """Scrape Starship"""
        infobox = self._scrape_web(entity_name)
        image_url = infobox.find(
            "figure",
            class_="pi-item pi-image",
        )

        image_url = image_url.find("img")["src"] if image_url else None

        product_line = infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "line"},
        )
        product_line = product_line.find("a").text if product_line else None

        info_dict = {
            "image_url": image_url,
            "product_line": product_line,
        }

        return info_dict
