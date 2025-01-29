fetch('/maintenance.lock', { method: 'HEAD' })
    .then(response => {
        if (response.ok) {
            // If the maintenance.lock file exists, the site is offline
            document.body.innerHTML = "Website Offline";

            // Redirect to offline.html
            window.location.href = 'offline.html';  // Open the offline page
        }
    })
    .catch(err => {
        // If there's an error (e.g., file doesn't exist), the website is online
        console.log("Website is online");
    });
