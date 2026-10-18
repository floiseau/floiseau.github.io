// Fetch publications from HAL API
async function fetchHALPublications() {
  const apiUrl = 'https://api.archives-ouvertes.fr/search?q=authIdHal_s:flavien-loiseau&rows=500&fl=title_s,authFullName_s,publicationDateY_i,doiId_s,uri_s,halId_s,docType_s,journalTitle_s&sort=publicationDateY_i desc';
  
  const container = document.getElementById('publications-container');
  
  try {
    const response = await fetch(apiUrl);
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    const data = await response.json();
    let publications = data.response.docs;
    
    // Filter to include journal articles and preprints
    publications = publications.filter(pub => {
      const type = (pub.docType_s || '').toUpperCase();
      // Include if it has a journal title OR is a preprint
      return type.includes("ART") || type.includes('UNDEFINED');
    });
    
    if (publications.length === 0) {
      document.getElementById('publications-container').innerHTML = '<p>No publications found.</p>';
      return;
    }
    
    // Group by year
    const publicationsByYear = {};
    publications.forEach(pub => {
      const year = pub.publicationDateY_i || 'Unknown';
      if (!publicationsByYear[year]) {
        publicationsByYear[year] = [];
      }
      publicationsByYear[year].push(pub);
    });
    
    // Sort years in descending order
    const sortedYears = Object.keys(publicationsByYear).sort((a, b) => b - a);
    
    // Generate HTML
    let html = '';
    for (const year of sortedYears) {
      html += `<h3 id="year-${year}">${year}</h3>`;
      html += '<div class="publications-year">';
      
      // Sort publications by title
      publicationsByYear[year].sort((a, b) => a.title_s[0].localeCompare(b.title_s[0]));
      
      for (const pub of publicationsByYear[year]) {
        const title = pub.title_s ? pub.title_s[0] : 'Untitled';
        const authors = pub.authFullName_s ? pub.authFullName_s.join(', ') : '';
        const halId = pub.halId_s || '';
        const doi = pub.doiId_s || '';
        const uri = pub.uri_s || '';
        const journal = pub.journalTitle_s || '';
        const type = pub.docType_s || '';
        
        // Highlight your name in authors
        const highlightedAuthors = authors.replace(/Flavien Loiseau/gi, '<strong>Flavien Loiseau</strong>');
        
        // Determine the venue - use journal if available, otherwise "Preprint" for preprints
        let venue = journal;
        if (type.includes('UNDEFINED')) {
          venue = 'Preprint submitted for publication.';
        }
        
        // Build the publication entry
        html += '<div class="publication-entry">';
        
        // Title with HAL link
        html += `<div class="publication-title">`;
        if (uri) {
          html += `<a href="${uri}" target="_blank" rel="noopener noreferrer">${title}</a>`;
        } else {
          html += title;
        }
        html += '</div>';
        
        // Authors
        html += `<div class="publication-authors">${highlightedAuthors}</div>`;
        
        // Venue (journal or "Preprint")
        if (venue) {
          html += '<div class="publication-journal">';
          html += `<em>${venue}</em>`;
          html += '</div>';
        }
        
        // DOI and links
        html += '<div class="publication-links">';
        if (doi) {
          html += `<a href="https://doi.org/${doi}" target="_blank" rel="noopener noreferrer" class="doi-badge">DOI</a>`;
        }
        if (halId) {
          html += `<a href="https://hal.science/${halId}" target="_blank" rel="noopener noreferrer" class="hal-badge">HAL</a>`;
        }
        html += '</div>';
        
        html += '</div>';
      }
      
      html += '</div>';
    }
    
    document.getElementById('publications-container').innerHTML = html;
    
  } catch (error) {
    console.error('Error fetching publications:', error);
    document.getElementById('publications-container').innerHTML = '<p>Error loading publications. Please try again later.</p>';
  }
}

// Call the function when the page loads
document.addEventListener('DOMContentLoaded', fetchHALPublications);
