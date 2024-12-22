from urllib.request import urlopen
from bs4 import BeautifulSoup as soup


class WookieepediaScraping:
    """
    Class to scrap online
    """

    def __init__(self, url):
        """Init class"""
        url_data = urlopen(url)
        url_html = url_data.read()
        url_data.close()

        html = soup(url_html, "html.parser")
        self.infobox = html.find("aside", class_="portable-infobox")

    def scrape_character(self):
        """Scrape character"""
        image_url = self.infobox.find(
            "figure",
            class_="pi-item pi-image",
        )

        image_url = image_url.find("img")["src"] if image_url else None

        home_world = self.infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "homeworld"},
        )
        home_world = home_world.find("a").text if home_world else None

        species = self.infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "species"},
        )
        species = species.find("a").text if species else None

        sex = self.infobox.find(
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

    def scrape_creature(self):
        """Scrape creature"""
        image_url = self.infobox.find(
            "figure",
            class_="pi-item pi-image",
        )

        image_url = image_url.find("img")["src"] if image_url else None

        home_world = self.infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "planet"},
        )
        home_world = home_world.find("a").text if home_world else None

        designation = self.infobox.find(
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

    def scrape_droid(self):
        """Scrape droid"""
        image_url = self.infobox.find(
            "figure",
            class_="pi-item pi-image",
        )

        image_url = image_url.find("img")["src"] if image_url else None

        class_type = self.infobox.find(
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

    def scrape_planet(self):
        """
        Scrape planet
        """
        image_url = self.infobox.find(
            "figure",
            class_="pi-item pi-image",
        )

        image_url = image_url.find("img")["src"] if image_url else None

        region = self.infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "region"},
        )
        region = region.find("a").text if region else None

        sector = self.infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "sector"},
        )
        sector = sector.find("a").text if sector else None

        system = self.infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "system"},
        )
        system = system.find("a").text if system else None

        capital_city = self.infobox.find(
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

    def scrape_source(self):
        """Scrape source"""
        image_url = self.infobox.find(
            "figure",
            class_="pi-item pi-image",
        )

        image_url = image_url.find("img")["src"] if image_url else None

        timeline = self.infobox.find(
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

    def scrape_species(self):
        """Scrape species"""
        image_url = self.infobox.find(
            "figure",
            class_="pi-item pi-image",
        )

        image_url = image_url.find("img")["src"] if image_url else None

        homeworld = self.infobox.find(
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

    def scrape_starship_model(self):
        """Scrape starship model"""
        image_url = self.infobox.find(
            "figure",
            class_="pi-item pi-image",
        )

        image_url = image_url.find("img")["src"] if image_url else None

        class_type = self.infobox.find(
            "div",
            class_="pi-item pi-data pi-item-spacing pi-border-color",
            attrs={"data-source": "type"},
        )
        class_type = class_type.find("a").text if class_type else None

        line = self.infobox.find(
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

    def scrape_model(self):
        """Scrape model"""
        image_url = self.infobox.find(
            "figure",
            class_="pi-item pi-image",
        )

        image_url = image_url.find("img")["src"] if image_url else None

        product_line = self.infobox.find(
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
